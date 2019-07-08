#!/usr/bin/env python
# -*- coding: utf-8 -*-


import cv2
import numpy as np
import os
from sklearn.svm import SVC
from sklearn.externals import joblib
import gnugo_play as gp
from sklearn.preprocessing import MinMaxScaler
#from train_color import preprocess as preprocess_color


#   ------init-------
boardSize = 19
cap = cv2.VideoCapture(0)
cap.set(cv2.CAP_PROP_FRAME_WIDTH,640)
cap.set(cv2.CAP_PROP_FRAME_HEIGHT,360)
cap.set(5,10)   
projective_martix = np.loadtxt("transformer.txt")  
cv2.namedWindow('result') 
cv2.namedWindow('board') 
model_path1 = "/home/mrobot/go_opencv/src/model/train_model_color.m" 
model_path2 = "/home/mrobot/go_opencv/src/model/train_model_poi.m" 
model_color = joblib.load(model_path1)  
model_poi = joblib.load(model_path2) 

#   -----------------


class FeatureExtractor_color:
    @classmethod
    def fd_hu_moments(cls, image):
#        image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
        feature = cv2.HuMoments(cv2.moments(image)).flatten()
        #print("hu", feature.shape)
        return feature
    '''
    @classmethod
    def fd_haralick(cls, image):    # convert the image to grayscale
        gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
        # compute the haralick texture feature vector
        haralick = mahotas.features.haralick(gray).mean(axis=0)
        return haralick
    '''
    @classmethod
    def fd_histogram(cls, image, mask=None, bins=10):
        # convert the image to HSV color-space
#        image = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)
        # compute the color histogram
        hist_0  = cv2.calcHist([image], [0], None, [bins], [0, 256])
        hist_1  = cv2.calcHist([image], [1], None, [bins], [0, 256])
        hist_2  = cv2.calcHist([image], [2], None, [bins], [0, 256])
        # normalize the histogram
        cv2.normalize(hist_0, hist_0)
        cv2.normalize(hist_1, hist_1)
        cv2.normalize(hist_2, hist_2)
        hist = np.concatenate([hist_0, hist_1, hist_2], axis=0).flatten()
        #print("hist", hist.shape)
        return hist

    @classmethod
    def getFeatures(cls, hsv, gray):
        global_features = np.hstack([cls.fd_histogram(hsv), cls.fd_hu_moments(gray)]).reshape(-1,1)
        scaler = MinMaxScaler(feature_range=(0, 1))
        #Normalize The feature vectors...
        rescaled_features = scaler.fit_transform(global_features)
        return rescaled_features.reshape(-1)

def preprocess_color(hsv,gray):
    return FeatureExtractor_color.getFeatures(hsv,gray)


def preDict(img1,img2,img3):
    global model_color, model_poi
#'''
#    arg = np.zeros((1,20))
#    h,w,d = img1.shape
#    hist1, bins1 = np.histogram(img1[:, :, 0].ravel(), bins = [0,25,50,75,100,125,150,175,200,225,260]) 
##    hist1, bins1 = np.histogram(img1[:, :, 0].ravel(), bins = 10)   
#    arg[0,0:10] = hist1 / float(h*w)
#    hist2, bins2 = np.histogram(img2[:, :, 1].ravel(), bins = [0,10,20,30,40,50,60,70,80,90,100]) 
##    hist2, bins2 = np.histogram(img2[:, :, 0].ravel(), bins = 10)   
#    arg[0,10:20] = hist2 / float(h*w)
#    result = int(model_color.predict([arg.ravel()]))
#'''
    result = int(model_color.predict([preprocess_color(img1,img2)]))
#    if result == 2:
#        result = int(model_poi.predict([np.mean(img3, axis=0)]))

    return result
   
       


    


#   ------transfomer--------
def transfomer(src): 
    global projective_martix  
    matrix = np.zeros((19,19),np.uint8)       
    proj = cv2.warpPerspective(src, projective_martix,(580,595))
    hsv = cv2.cvtColor(proj, cv2.COLOR_BGR2HSV)
    cv2.imshow('result', proj)
    cv2.waitKey(0)
    gray_roi = cv2.cvtColor(proj, cv2.COLOR_BGR2GRAY) 
    th = cv2.adaptiveThreshold(gray_roi,255,cv2.ADAPTIVE_THRESH_GAUSSIAN_C,cv2.THRESH_BINARY,11,2)

#   ------board seperator--------
#   ---x-range: 19~559,  y-range: 19~577-----     
    for i in range (0,19):
        for j in range (0,19):
            center = (20+i*30,15+j*31)
            box1 = hsv[(center[1]-15):(center[1]+15),(center[0]-15):(center[0]+15)]
            box2 = gray_roi[(center[1]-15):(center[1]+15),(center[0]-15):(center[0]+15)]
            box3 = th[(center[1]-15):(center[1]+15),(center[0]-15):(center[0]+15)]
            matrix[i][j] = preDict(box1,box2,box3)
#            if matrix[i][j] ==1:
#                light_rec = np.mean(box1)
#                print(i,j,light_rec)
#                if light_rec > 110:
#                    matrix[i][j] = 0
      
    return matrix
                
#   ------------------------
#   ------board display-------
# displaying the board

# make a blank board
def blankBoard(boardBlockSize):
    yellow = [75, 215, 255]
    black = [0, 0, 0]
    white = [255, 255, 255]
    halfBoardBlock = int(round((boardBlockSize / 2.0)))
    boardSide = boardBlockSize * boardSize
    blankBoard = np.zeros((boardSide, boardSide, 3),
                     dtype="uint8")
    cv2.rectangle(blankBoard, (0, 0), (boardSide, boardSide), yellow, -1)
    for i in range(boardSize):
        spot = i * boardBlockSize + halfBoardBlock
        cv2.line(blankBoard,
                 (spot, halfBoardBlock),
                 (spot, boardSide - halfBoardBlock),
                 black,
                 boardBlockSize / 10)
        cv2.line(blankBoard,
                 (halfBoardBlock, spot),
                 (boardSide - halfBoardBlock, spot),
                 black,
                 boardBlockSize / 10)
    if boardSize == 19:
        spots = [[3, 3], [9, 3], [15, 3],
                 [3, 9], [9, 9], [15, 9],
                 [3, 15], [9, 15], [15, 15]]
    else:
        spots = []

    for s in spots:
        cv2.circle(blankBoard,
                   (s[0] * boardBlockSize + halfBoardBlock,
                    s[1] * boardBlockSize + halfBoardBlock),
                   int(boardBlockSize * .15),
                   black,
                   -1)

    return blankBoard

def drawBoard(board, size=(500, 500)):
    black = [0, 0, 0]
    white = [255, 255, 255]
    
    boardBlockSize = 100
    halfBoardBlock = int(round(boardBlockSize / 2.0))
    output =  blankBoard(100)
    (w, h) = board.shape
    for x in range(w):
        for y in range(h):
            if board[x][y] == 1:
                cv2.circle(output,
                           ((x * boardBlockSize) + halfBoardBlock,
                            (y * boardBlockSize) + halfBoardBlock),
                           boardBlockSize / 2,
                           black,
                           -1)
            elif board[x][y] == 2:
                cv2.circle(output,
                           ((x * boardBlockSize) + halfBoardBlock,
                            (y * boardBlockSize) + halfBoardBlock),
                           boardBlockSize / 2,
                           white,
                           -1)
    output = cv2.resize(output, size, output, 0, 0, cv2.INTER_AREA)
    return output


def main(): 
    for i in range(0,40):
        ret, img = cap.read() 
        cv2.waitKey(10)  
    board = np.zeros((boardSize, boardSize), dtype="uint8")
    lastboard = board
    cv2.imshow("board", drawBoard(board))
    cv2.waitKey()
    ai = gp.play_ai()
    while True:
        for i in range(0,10):
            ret, img = cap.read() 
            cv2.waitKey(10)  
        img_board = transfomer(img)
#        change_board = img_board-lastboard
#        diff_step = np.argwhere(change_board == 2)
#        print(diff_step,len(diff_step))


#----------if ai is black-------------
#        if np.sum(board) == 0:
#            ai_step, board = ai.gogogo((-1,-1))
#        else:  
#            if len(diff_step) != 1:
#                player_step = (input("please input the true step index 1: "),input("please input the true step index 2: "))
#            else:            
#                player_step = tuple(diff_step[0])
#            ai_step, board = ai.gogogo(player_step)


#        if ai_step == (-1,-1):
#            print('finished!')
#            break
#        lastboard = board
        cv2.imshow("board", drawBoard(img_board))
        cv2.waitKey()





main()
