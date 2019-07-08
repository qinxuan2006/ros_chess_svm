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
from sklearn.preprocessing import MinMaxScaler

from os.path import join

#def preprocess(img1,img2):
#    arg = np.zeros((1,20))
#    h,w,d = img1.shape
#    hist1, bins1 = np.histogram(img1[:, :, 0].ravel(), bins = [0,25,50,75,100,125,150,175,200,225,260]) 
##    hist1, bins1 = np.histogram(img1[:, :, 0].ravel(), bins = 10)  
#    arg[0,0:10] = hist1 / float(h*w)
#    hist2, bins2 = np.histogram(img2[:, :, 1].ravel(), bins = [0,10,20,30,40,50,60,70,80,90,100]) 
##    hist2, bins2 = np.histogram(img2[:, :, 0].ravel(), bins = 10) 
#    arg[0,10:20] = hist2 / float(h*w)
#    return arg.ravel()
##    result = np.mean(img, axis=0)
##    print count,result
##    return result

class FeatureExtractor:
    @classmethod
    def fd_hu_moments(cls, image):
        image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
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
        image = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)
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
    def getFeatures(cls, image_origin):
        image = cv2.resize(image_origin, (200,200))
        global_features = np.hstack([cls.fd_histogram(image), cls.fd_hu_moments(image)]).reshape(-1,1)
        scaler = MinMaxScaler(feature_range=(0, 1))
        #Normalize The feature vectors...
        rescaled_features = scaler.fit_transform(global_features)
        return rescaled_features.reshape(-1)

def preprocess(image_origin):
    return FeatureExtractor.getFeatures(image_origin)

def loadSubDataset(sub_dir_name):
    if not os.path.exists(sub_dir_name):
        return 0
    img_list = os.listdir(sub_dir_name)

    for i, img_name in enumerate(img_list):    
        img = cv2.imread(join(sub_dir_name, img_name))
        if i == 0:
            x_data_0 = preprocess(img)
            x_data = np.zeros((len(img_list), x_data_0.shape[0]))
            x_data[0, :] = x_data_0
        else:
            x_data[i, :] = preprocess(img)
    return x_data

def loadDataset(dir_name):
    
    labeled_data = {}
    label_names = ["blank","black", "white"]
    for label in label_names:
        labeled_data[label] = loadSubDataset(join(dir_name, label))
#        print join(dir_name, label)
#        print("load %s data : %d" %(label, labeled_data[label].shape[0]) )
    
    x_data = np.concatenate([labeled_data[label] for label in label_names], axis=0)
    
    y_data = np.zeros(x_data.shape[0], dtype=np.int)
    last_num = 0
    for i,label in enumerate(label_names):
        num = labeled_data[label].shape[0]
        y_data[last_num:last_num+num] = i
        last_num = last_num + num
    
    return x_data, y_data 

def train(dir_name, save_dir, save_name):
    x_data, y_data = loadDataset(dir_name)


    clf = SVC(C=1.0, cache_size=200, class_weight=None, coef0=0.0,
            decision_function_shape='ovr', degree=3, gamma='scale', kernel='rbf',
            max_iter=-1, probability=False, random_state=None, shrinking=True,
            tol=0.001, verbose=False) 
    clf.fit(x_data,y_data)
    if not os.path.exists(save_dir):
        os.makedirs(save_dir)
    joblib.dump(clf, join(save_dir, save_name))

    train_score = clf.score(x_data,y_data) 
    print("for save_name: ", save_name)
    print("train_score: ", train_score)



if __name__ == "__main__":
#    rospy.init_node('svm_trainer')
#    rospy.loginfo('started')
#    rospack = rospkg.RosPack()
#    data_dir = join(rospack.get_path('mm_pattern_recognition'), "data/light/processed")
#    save_dir = join(rospack.get_path('mm_pattern_recognition'), "src/svm_test/model")
    data_dir = '/home/mrobot/go_opencv/src'
    save_dir = '/home/mrobot/go_opencv/src/model'
    train(dir_name=data_dir,save_dir=save_dir, save_name="train_model_color.m")  
#    train(dir_name=join(data_dir,"down"),save_dir=save_dir, save_name="train_model_down.m") 

'''
def train():
    # change dir for different dataset (e.g.up and down)
    img_file = '/home/mrobot/go_opencv/src/blank/'
    img_list = os.listdir(img_file)
    x_data = np.zeros((385,20)) 
    y_data = np.ones((385,1), dtype=np.int16)
    count = 0
    for img_name in img_list:    
        src = cv2.imread(img_file + img_name) 
#        gray = cv2.cvtColor(src, cv2.COLOR_BGR2GRAY)
#        ret,thresh1=cv2.threshold(gray,100,255,cv2.THRESH_BINARY) 
#        cv2.imshow('tset',thresh1)
#        cv2.waitKey() 
#        hsv = cv2.cvtColor(src, cv2.COLOR_BGR2HSV) 
        x_data[count,:] = preprocess(src)     
        y_data[count] = 0
        count += 1  

    img_file = '/home/mrobot/go_opencv/src/black/'
    img_list = os.listdir(img_file) 
    for img_name in img_list:    
        src = cv2.imread(img_file + img_name) 
#        gray = cv2.cvtColor(src, cv2.COLOR_BGR2GRAY)
#        ret,thresh1=cv2.threshold(gray,100,255,cv2.THRESH_BINARY) 
#        cv2.imshow('tset',thresh1)
#        cv2.waitKey() 
#        hsv = cv2.cvtColor(src, cv2.COLOR_BGR2HSV)    
        x_data[count,:] = preprocess(src)
        y_data[count] = 1
        count += 1   

    img_file = '/home/mrobot/go_opencv/src/white/'
    img_list = os.listdir(img_file) 
    for img_name in img_list:    
        src = cv2.imread(img_file + img_name) 
#        hsv = cv2.cvtColor(src, cv2.COLOR_BGR2HSV)    
        x_data[count,:] = preprocess(src)     
        y_data[count] = 2
        count += 1   


    clf = SVC(C=1.0, cache_size=200, class_weight=None, coef0=0.0,
        decision_function_shape='ovr', degree=3, gamma='scale', kernel='rbf',
        max_iter=-1, probability=False, random_state=None, shrinking=True,
        tol=0.001, verbose=False) 
    clf.fit(x_data,y_data.ravel()) 
    os.chdir("./model/")
    joblib.dump(clf, "train_model_color.m")

    score = clf.score(x_data,y_data.ravel()) 
    print(score)

#src = cv2.imread('rec3.png')
#for i in range (0,19):
#    for j in range (0,19):
#        center = (20+i*30,15+j*31)
#        box = src[(center[1]-15):(center[1]+15),(center[0]-15):(center[0]+15)]
##        print(preprocess(box))
#        name = "2-%d%d.png" % (i,j)
#        cv2.imwrite(name,box) 

#src = cv2.imread('src1.png')

#img_bgr_data = src
#print(preprocess(src))
#src = cv2.imread('1810.png')

train()
'''


