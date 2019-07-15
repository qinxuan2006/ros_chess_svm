#!/usr/bin/env python
# -*- coding: utf-8 -*-


import cv2
import numpy as np
import os
import roslib
import rospy
import rospkg
from sklearn.svm import SVC
from sklearn.externals import joblib
import gnugo_play as gp
from sklearn.preprocessing import MinMaxScaler
from std_msgs.msg import Int8MultiArray, String
from go_player.srv import *

#----------capture parameters-----------
cap = cv2.VideoCapture(0)
cap.set(cv2.CAP_PROP_FRAME_WIDTH,640)
cap.set(cv2.CAP_PROP_FRAME_HEIGHT,360)
cap.set(5,10) 
count =1
for i in range(0,20):
    ret, img = cap.read() 
    cv2.waitKey(200)  
    count +=1
print count
#---------------------------------------




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


class CaptureAndProcess():
#   ------init-------
    def __init__(self):

        rospy.init_node('chess_recognition')
        rospy.loginfo('started')
        self.player_command = rospy.Service("/go/command", Player_order, self.handle_order_func)
  
        rospack = rospkg.RosPack()
        pkg_pth = rospack.get_path('go_player')
        self.projective_martix = np.loadtxt(pkg_pth +"/src/transformer.txt")
        print self.projective_martix
        self.model_color = joblib.load(pkg_pth + "/src/model/train_model_color.m") 
        self.board = np.zeros((19,19),np.uint8)
        self.bw = {'black':2,'white':1}
        self.abw = {'black':-2,'white':-1}
        rospy.sleep(0.2) 


#   -----------------


    def preprocess_color(self,hsv,gray):
        return FeatureExtractor_color.getFeatures(hsv,gray)


    def preDict(self,img1,img2):
        result = int(self.model_color.predict([self.preprocess_color(img1,img2)]))
        return result
   
    #   ------transfomer--------
    def transfomer(self,src):  
        matrix = np.zeros((19,19),np.uint8)       
        proj = cv2.warpPerspective(src, self.projective_martix,(580,595))
        hsv = cv2.cvtColor(proj, cv2.COLOR_BGR2HSV)
        gray_roi = cv2.cvtColor(proj, cv2.COLOR_BGR2GRAY)

    #   ------board seperator--------
    #   ---x-range: 19~559,  y-range: 19~577-----     
        for i in range (0,19):
            for j in range (0,19):
                center = (20+i*30,15+j*31)
                box1 = hsv[(center[1]-15):(center[1]+15),(center[0]-15):(center[0]+15)]
                box2 = gray_roi[(center[1]-15):(center[1]+15),(center[0]-15):(center[0]+15)]
                matrix[i][j] = self.preDict(box1,box2)
          
        return matrix
                

    def handle_order_func(self,msg):
        isExcuted = False
        who = '--'
        ai_step = (-1,-1)
        remove_step = ()
        for i in range(0,5):
            ret, img = cap.read() 
            cv2.waitKey(100) 
            img_board = self.transfomer(img)  
        print img_board

        if msg.state == 'new':   
            self.kind = msg.kind         
            if np.sum(img_board) != 0:
                rospy.logwarn('please clear the real board') 
            else:
                self.ai = gp.play_ai(msg.kind,msg.level)
                ai_step, gnu_board = self.ai.gogogo((-1,-1))
                self.board = gnu_board
            isExcuted = True


        elif msg.state == 'play':
            change_board = img_board-self.board
            diff_step = np.argwhere(change_board == self.bw[self.kind])
            rospy.loginfo((diff_step,len(diff_step)))
            if len(diff_step) != 1:
                player_step = (input("please input the true step index 1: "),input("please input the true step index 2: "))
            else:            
                player_step = tuple(diff_step[0])
                self.board[player_step[0]][player_step[1]] = self.bw[self.kind]
            ai_step, gnu_board = self.ai.gogogo(player_step)
            if ai_step == (-1,-1):
                if self.board == 'B' or self.board == 'W':
                    rospy.loginfo('finished! %s wins', self.board)
                    who = self.board
                else:
                    rospy.logerr('error!')
                    return Player_orderResponse(isExcuted, ai_step, remove_step, who) 
            else:
                change_board = gnu_board-self.board
                remove_step = np.argwhere(change_board == self.abw[self.kind])
                self.board = gnu_board

            isExcuted = True        


                       
        elif msg.state == 'resume':
            self.board = img_board
            isExcuted = True
            pass


        return Player_orderResponse(isExcuted, ai_step, remove_step, who)




if __name__ == '__main__':
    chess_rec = CaptureAndProcess()
    rospy.spin()
