#!/usr/bin/env python
# -*- coding: utf-8 -*-

import cv2
import numpy as np
import time
import roslib
import rospy
import rospkg
# -----------------------鼠标操作相关------------------------------------------
lsPointsChoose = []
tpPointsChoose = []
pointsCount = 0
count = 0
pointsMax = 4


def on_mouse(event, x, y, flags, param):
    global src,  pointsMax
    global lsPointsChoose, tpPointsChoose  # 存入选择的点
    global pointsCount  # 对鼠标按下的点计数
    global img2
    gray_img = cv2.cvtColor(src,cv2.COLOR_BGR2GRAY)
    img2 = src.copy()  # 此行代码保证每次都重新再原图画  避免画多了
    # -----------------------------------------------------------
    #    count=count+1
    #    print("callback_count",count)
    # --------------------------------------------------------------
 
    if event == cv2.EVENT_LBUTTONDOWN:  # 左键点击
        pointsCount = pointsCount + 1
        print('pointsCount:', pointsCount)
        point1 = [x, y]
        point1 = optPoint(gray_img,point1,pointsCount)
        # 画出点击的点
        cv2.circle(img2, tuple(point1), 5, (0, 255, 0), 1)
 
        # 将选取的点保存到list列表里
        lsPointsChoose.append(point1)  # 用于转化为darry 提取多边形ROI
        tpPointsChoose.append(tuple(point1))  # 用于画点
        # ----------------------------------------------------------------------
        # 将鼠标选的点用直线连起来
        for i in range(len(tpPointsChoose) - 1):
            cv2.line(img2, tpPointsChoose[i], tpPointsChoose[i + 1], (0, 0, 255), 2)
        # ----------------------------------------------------------------------
        # ----------点击到pointMax时可以提取去绘图----------------
        if (pointsCount == pointsMax):
            # -----------绘制感兴趣区域-----------
            result = persepective(src)
#            ini_matrix(result)
            lsPointsChoose = []
            tpPointsChoose = []
            pointsCount = 0
 
        cv2.imshow('src', img2)
    # -------------------------右键按下清除轨迹-----------------------------
    if event == cv2.EVENT_RBUTTONDOWN:  # 右键点击
        print("right-mouse")
        pointsCount = 0
        tpPointsChoose = []
        lsPointsChoose = []




def persepective(image):
    pts = np.array([lsPointsChoose], np.int32)  
    pts = pts.reshape((-1, 1, 2))
    print pts    
    cols,rows,channel = (580,595,3)

    dst_points = np.float32([[19,19],[cols-20,19],[cols-20,rows-20],[19,rows-20]])
    src_points = np.float32([pts[0],pts[1],pts[2],
                             pts[3]])
     
    projective_martix = cv2.getPerspectiveTransform(src_points,dst_points)
     
    projective_image = cv2.warpPerspective(image,
                                           projective_martix,(cols,rows))
    rospack = rospkg.RosPack()
    pkg_pth = rospack.get_path('go_player') 
    cv2.imshow('Projective Image',projective_image)  
    cv2.imwrite(pkg_pth+'/src/rec.jpg', projective_image)   
    cv2.waitKey()
    print projective_martix
    np.savetxt(pkg_pth+"/src/transformer.txt", projective_martix) # 缺省按照'%.18e'格式保存数据，以空格分隔 
    return projective_image

def optPoint(img,point,offset_num):
    print ("before: ", point)
    roi = img[(point[1]-5):(point[1]+5),(point[0]-5):(point[0]+5)]
    cv2.imshow('roi Image',roi) 
    cv2.waitKey()
    new_point = [point[0] + harris(roi)[1] - 5,point[1] + harris(roi)[0] - 5]
    if offset_num == 1:
#        new_point[0] -= 1
        new_point[1] -= 2        
    if offset_num == 2:
        new_point[1] -= 2
    print ("after: ", new_point)
    return new_point

def harris(img):
    sumx = 0
    sumy = 0
    count = 0
    #对图像执行harris
    Harris_detector = cv2.cornerHarris(img, 2, 3, 0.04)
    #腐蚀harris结果
    dst = cv2.dilate(Harris_detector,None)
    # 设置阈值
    thres = 0.1*dst.max()
    for i in range (0,10):
        for j in range (0,10):
            if dst[i][j]>thres:
                sumx+=i
                sumy+=j
                count+=1
    avgx = sumx/count
    avgy = sumy/count
#    img[dst > thres] = 255
#    cv2.imshow('rec Image',img) 
#    cv2.waitKey()
    return [avgx,avgy]

def roi_rec(x,y,img):
    mask = np.zeros(img.shape, np.uint8)
    mask2 = cv2.circle(mask, (x,y), 15, (255, 255, 255), -1)
    ROI = cv2.bitwise_and(mask2, img)
    return ROI


def ini_matrix(img):
    matrix = np.zeros((19,19))
    for i in range (0,19):
        for j in range (0,19):
            center = (20+i*30,15+j*31)
            roi = roi_rec(20+i*30, 15+j*31, img)
#            hsv = cv2.cvtColor(roi, cv2.COLOR_BGR2HSV)
            gray_roi = cv2.cvtColor(roi, cv2.COLOR_BGR2GRAY) 
            avg = np.average(gray_roi)
            print(avg)
            matrix[i,j] = avg
    np.savetxt("comparison.txt", matrix)

cap = cv2.VideoCapture(0)
cap.set(cv2.CAP_PROP_FRAME_WIDTH,640)
cap.set(cv2.CAP_PROP_FRAME_HEIGHT,360)
cv2.namedWindow('src')
count =0

if __name__ == '__main__':
    rospy.init_node('rec_board')
    rospy.loginfo('started')
    while True:
        ret, src = cap.read() 
        print cap.get(3)
        print cap.get(4)
        print cap.get(cv2.CAP_PROP_FPS)
        cv2.imshow('src', src)
        cv2.waitKey(10)
        count+=1
        if count > 20:
            break
    cv2.setMouseCallback('src', on_mouse)
    cv2.imshow('src', src)
    cv2.waitKey()


    cv2.destroyAllWindows()

