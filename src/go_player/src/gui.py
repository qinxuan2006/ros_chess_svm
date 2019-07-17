#!/usr/bin/env python
#-*-coding:GBK -*-

import os, sys
import rospy
import rospkg
import RPi.GPIO as GPIO
import threading
import time
from std_msgs.msg import String
from python_qt_binding import loadUi
from PyQt5 import QtCore, QtGui, QtWidgets
from go_player.srv import *

_isExcuted=threading.Event()





def go_client_srv(m,p,n):  
    rospy.wait_for_service("/go/command")    
    try:  
        go_client = rospy.ServiceProxy("/go/command",Player_order)       
        resp = go_client(m,p,n) 
        return resp.success, resp.do_step, resp.remove_step, resp.win_side
    except rospy.ServiceException, e:  
        print "Service call failed: %s"%e 

def arduino_client_srv(m,p):  
    rospy.wait_for_service("/go/arduino")    
    try:  
        arduino_client = rospy.ServiceProxy("/go/arduino",Arduino_order)       
        resp = arduino_client(m,p) 
        return resp.success
    except rospy.ServiceException, e:  
        print "Service call failed: %s"%e 

def button_go(channel):
    rospy.sleep(0.5)
    _isExcuted.set()


class pyGui(QtWidgets.QWidget):
    def __init__(self):
        super(pyGui, self).__init__()
        rospack = rospkg.RosPack()
        pkg_pth = rospack.get_path('go_player')
        ui_file = os.path.join(pkg_pth, 'src/pygui.ui')
        loadUi(ui_file, self)
        rospy.init_node('py_gui')

        pin = 11
        GPIO.setmode(GPIO.BOARD)
        GPIO.setup(pin,GPIO.IN)
        GPIO.add_event_detect(pin,GPIO.FALLING,callback = button_go,bouncetime = 500)

        self.arduinoPre = rospy.Publisher('/go/arduinoPre', String , queue_size=10)       

        self.is_pub = False
        self.current_level = self.level_slider.value()
        self.level_label.setText(u'AI级别: ' + str(self.current_level))
        self.start_button.pressed.connect(self.publish_start)
        self.quit_button.pressed.connect(self.gui_close)
        self.level_slider.valueChanged.connect(self.change_level)
        self.black_radio.clicked.connect(self.black_chosen)
        self.white_radio.clicked.connect(self.white_chosen)
        rospy.sleep(0.5)

        
 
    def publish_start(self):
        if self.black_radio.isChecked():
            self.hukind = 'black'
            self.kind = 'white'
        elif self.white_radio.isChecked():
            self.hukind = 'white'
            self.kind = 'black'
        self.arduinoPre.publish(String('prepare')) 
        try:
            self.isExcuted, self.pc_do_step, self.pc_remove_step, self.win_side = go_client_srv("new",self.kind,str(self.current_level))
            print self.isExcuted, self.pc_do_step, self.pc_remove_step,self.win_side
            if True == self.isExcuted:
                if not (-1,-1) == self.pc_do_step:
                    robotExcuted = arduino_client_srv("place",self.pc_do_step)
                self.start_button.setEnabled(False)
                self.is_pub = True                   
        except Exception as e:
            res = QtWidgets.QMessageBox.warning(self,u'错误',u'请正先选择颜色及难度',QtWidgets.QMessageBox.Ok)
            print e
        if True == self.is_pub:
            while not rospy.is_shutdown():
                self.player_go() 
 
    def change_level(self, value):
        self.current_level = value
        self.level_label.setText(u'AI级别: ' + str(value))

    def black_chosen(self):
        self.black_radio.setChecked(True)

    def white_chosen(self):
        self.white_radio.setChecked(True)

    def player_go(self):
        _isExcuted.wait()
        self.arduinoPre.publish(String('prepare'))
        try:
            self.isExcuted, self.pc_do_step, self.pc_remove_step, self.win_side = go_client_srv("play",self.hukind,str(self.current_level))
            print self.isExcuted, self.pc_do_step,  self.pc_remove_step, self.win_side
            if not (-1,-1) == self.pc_do_step:
                robotExcuted = arduino_client_srv("place",self.pc_do_step)
            if not () == self.pc_remove_step:
                robotExcuted = arduino_client_srv('remove',self.pc_remove_step) 
           
        except Exception as e:
            print e
        _isExcuted.clear()



    def gui_close(self):
        self.close()
 
 
def main():
    try:
        app=QtWidgets.QApplication(sys.argv)
        pyShow = pyGui()
        pyShow.show()
        sys.exit(app.exec_())
    except Exception as e:
        print e
 
 
if __name__ == "__main__":
    main()

