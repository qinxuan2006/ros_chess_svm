#! /usr/bin/env python
# -*- coding: utf-8 -*-

import serial
import time
import rospy
import rospkg
from go_player.srv import *
from std_msgs.msg import String
import threading



class ArduinoProcess():
#   ------init-------
    def __init__(self):

        rospy.init_node('arduino_processing')
        rospy.loginfo('started')
        self.arduino_pre = rospy.Subscriber('/go/arduinoPre', String, self.precallback)
        self.arduino_command = rospy.Service("/go/arduino", Arduino_order, self.handle_order_func)
        self._isPrepared=threading.Event()  
        serialPort = "/dev/arduino"  # 串口
        baudRate = 9600  # 波特率
        self.ser = serial.Serial(serialPort, baudRate, timeout=1)
        print("参数设置：串口=%s ，波特率=%d" % (serialPort, baudRate))
        rospy.sleep(0.2) 


    def precallback(self,msg):
        if 'prepare' == msg.data:
            if self._isPrepared.isSet():
                pass
            else:
                self.ser.write(msg.data.encode())
                while True:
                    try:
                        str1 = self.ser.readline().replace('\r\n','')
                        if len(str1)>0:
                        	print str1,len(str1) 
                        if 'done' == str1:
                            rospy.sleep(0.2)
                            isExcuted = True 
                            self._isPrepared.set()  
                            break
                    except Exception as e:
                        print e


    def handle_order_func(self,msg):
        isExcuted = False
        if not msg.state in ['place','remove']:
            return isExcuted
        if 'place' == msg.state:
            self._isPrepared.wait()
        rospy.sleep(0.2)
        orderStr = msg.state + '=' + str(msg.step)
#        print orderStr
        self.ser.write(orderStr.encode())    
        self._isPrepared.clear() 

        while True:
            try:
                str1 = self.ser.readline().replace('\r\n','')
                if len(str1)>0:
                	print str1,len(str1) 
                if 'done' == str1:
                    isExcuted = True  
                    break
            except Exception as e:
                print e
 

        return Arduino_orderResponse(isExcuted)

if __name__ == '__main__':
    ArduinoProcess()
    rospy.spin()

