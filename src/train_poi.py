#!/usr/bin/env python
# -*- coding: utf-8 -*-
from __future__ import division
import cv2
import numpy as np
import matplotlib.pyplot as plt
import os
from sklearn.svm import SVC
from sklearn.externals import joblib
from sklearn.decomposition import PCA

def preprocess(img,count):
#    arg = np.zeros((1,20))
#    h,w,d = img1.shape
#    hist1, bins1 = np.histogram(img1[:, :, 0].ravel(), bins = [0,25,50,75,100,125,150,175,200,225,260])  
#    arg[0,0:10] = hist1 / float(h*w)
#    hist2, bins2 = np.histogram(img2[:, :, 0].ravel(), bins = [0,18,36,54,72,90,108,126,144,162,180])  
#    arg[0,10:20] = hist2 / float(h*w)
#    return arg.ravel()
    result = np.mean(img, axis=0)
    print count,result
    return result

def train():
    # change dir for different dataset (e.g.up and down)
    img_file = '/home/mrobot/go_opencv/src/wu/'
    img_list = os.listdir(img_file)
    x_data = np.zeros((416,30)) 
    y_data = np.ones((416,1), dtype=np.int16)
    count = 0
    for img_name in img_list:    
        src = cv2.imread(img_file + img_name) 
        gray = cv2.cvtColor(src, cv2.COLOR_BGR2GRAY)
        ret,thresh1=cv2.threshold(gray,100,255,cv2.THRESH_BINARY) 
#        cv2.imshow('tset',thresh1)
#        cv2.waitKey() 
#        hsv = cv2.cvtColor(src, cv2.COLOR_BGR2HSV) 
        x_data[count,:] = preprocess(thresh1,count)     
        y_data[count] = 0
        count += 1  

    img_file = '/home/mrobot/go_opencv/src/you/'
    img_list = os.listdir(img_file) 
    for img_name in img_list:    
        src = cv2.imread(img_file + img_name) 
        gray = cv2.cvtColor(src, cv2.COLOR_BGR2GRAY)
        ret,thresh1=cv2.threshold(gray,100,255,cv2.THRESH_BINARY) 
#        cv2.imshow('tset',thresh1)
#        cv2.waitKey() 
#        hsv = cv2.cvtColor(src, cv2.COLOR_BGR2HSV)    
        x_data[count,:] = preprocess(thresh1,count)     
        y_data[count] = 2
        count += 1   

#    img_file = '/home/mrobot/go_opencv/src/white/'
#    img_list = os.listdir(img_file) 
#    for img_name in img_list:    
#        src = cv2.imread(img_file + img_name) 
##        hsv = cv2.cvtColor(src, cv2.COLOR_BGR2HSV)    
#        x_data[count,:] = preprocess(src)     
#        y_data[count] = 2
#        count += 1   


    clf = SVC(C=1.0, cache_size=200, class_weight=None, coef0=0.0,
        decision_function_shape='ovr', degree=3, gamma='scale', kernel='rbf',
        max_iter=-1, probability=False, random_state=None, shrinking=True,
        tol=0.001, verbose=False) 
    clf.fit(x_data,y_data.ravel()) 
    os.chdir("./model/")
    joblib.dump(clf, "train_model_poi.m")

    score = clf.score(x_data,y_data.ravel()) 
    print(score)

src = cv2.imread('src4.png')
for i in range (0,19):
    for j in range (0,19):
        center = (20+i*30,15+j*31)
        box = src[(center[1]-15):(center[1]+15),(center[0]-15):(center[0]+15)]
#        print(preprocess(box))
        name = "5-%d%d.png" % (i,j)
        cv2.imwrite(name,box) 

#src = cv2.imread('src1.png')

#img_bgr_data = src
#print(preprocess(src))
#src = cv2.imread('1810.png')

#train()



