#!/bin/bash 
source /opt/ros/kinetic/setup.bash
source ~/ros_chess_svm/devel/setup.bash

roslaunch go_player gostart.launch 


wait

exit 0
