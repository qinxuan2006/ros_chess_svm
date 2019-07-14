#!/usr/bin/env python
 #-*-coding:GBK -*-

import os, sys
import rospy
import rospkg
from std_msgs.msg import String
from python_qt_binding import loadUi
from PyQt5 import QtCore, QtGui, QtWidgets
from go_player.srv import * 

def go_client_srv(m,p,n):  
    rospy.wait_for_service("/go/command")    
    try:  
        go_client = rospy.ServiceProxy("/go/command",Player_order)       
        resp = go_client(m,p,n) 
        return resp.success, resp.do_step, resp.remove_step, resp.win_side
    except rospy.ServiceException, e:  
        print "Service call failed: %s"%e 


class pyGui(QtWidgets.QWidget):
    def __init__(self):
        super(pyGui, self).__init__()
        rospack = rospkg.RosPack()
        pkg_pth = rospack.get_path('go_player')
        ui_file = os.path.join(pkg_pth, 'src/pygui.ui')
        loadUi(ui_file, self)
#        self.pub = rospy.Publisher("pygui_topic", String, queue_size=10)
        rospy.init_node('py_gui')
        self.is_pub = False
        self.current_level = self.level_slider.value()
        self.level_label.setText(u'AI级别: ' + str(self.current_level))
        self.start_button.pressed.connect(self.publish_start)
        self.quit_button.pressed.connect(self.gui_close)
        self.play_button.pressed.connect(self.play_go)
        self.level_slider.valueChanged.connect(self.change_level)
        self.black_radio.clicked.connect(self.black_chosen)
        self.white_radio.clicked.connect(self.white_chosen)
 
    def publish_start(self):
        if self.black_radio.isChecked():
            self.kind = 'black'
            self.hukind = 'white'
        elif self.white_radio.isChecked():
            self.kind = 'white'
            self.hukind = 'black'
        try:
            self.start_button.setEnabled(False)
            self.is_pub = True
            self.isExcuted, self.pc_do_step, self.pc_remove_step, self.win_side = go_client_srv("new",self.kind,str(self.current_level))
            print self.isExcuted, self.pc_do_step,  self.pc_remove_step,self.win_side
        except Exception as e:
            res = QtWidgets.QMessageBox.warning(self,u'错误',u'请正先选择颜色及难度',QtWidgets.QMessageBox.Ok)
            print e

 
    def change_level(self, value):
        self.current_level = value
        self.level_label.setText(u'AI级别: ' + str(value))

    def black_chosen(self):
        self.black_radio.setChecked(True)

    def white_chosen(self):
        self.white_radio.setChecked(True)
 
    def play_go(self):
        if True == self.is_pub:
            try:
                self.isExcuted, self.pc_do_step, self.pc_remove_step, self.win_side = go_client_srv("play",self.hukind,str(self.current_level))
                print self.isExcuted, self.pc_do_step,  self.pc_remove_step,self.win_side
            except Exception as e:
                print e
        else:
            res = QtWidgets.QMessageBox.warning(self,u'错误',u'请先选择颜色及难度并点击开始按钮',QtWidgets.QMessageBox.Ok)

    def gui_close(self):
        self.close()
 
 
def main():
    app=QtWidgets.QApplication(sys.argv)
    pyShow = pyGui()
    pyShow.show()
    sys.exit(app.exec_())
 
 
if __name__ == "__main__":
    main()

