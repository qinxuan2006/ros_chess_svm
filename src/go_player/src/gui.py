#!/usr/bin/env python  
# -*- coding: utf-8 -*-  


import sys  
import rospy  
from go_player.srv import * 

def go_client_srv(m,p,n):  
    rospy.wait_for_service("/go/command")    
    try:  
        go_client = rospy.ServiceProxy("/go/command",Player_order)       
        resp = go_client(m,p,n) 
        print resp.success, resp.do_step, resp.remove_step, resp.win_side
        return resp.do_step
    except rospy.ServiceException, e:  
        print "Service call failed: %s"%e  
 

if __name__=="__main__":  
    rospy.init_node('go_gui')
    rospy.loginfo('started')
    pc_step = go_client_srv("new","black","6")  


