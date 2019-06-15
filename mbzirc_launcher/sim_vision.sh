#!/bin/bash

exit_script(){
    kill $GAZEBO_PID
    killall gzserver
    killall gzclient
    killall gazebo
}

trap exit_script SIGINT SIGTERM

source /opt/ros/melodic/setup.bash

if [ -f ~/.bash_mbzirc ]; then
    . ~/.bash_mbzirc
fi

#launch gazebo simulation with full world
roscd mbzirc_gazebo
gazebo --verbose gazebo_worlds/full.world &
GAZEBO_PID=$!

#launch the vision
roscore &

roslaunch mbzirc_vision ros_vision.launch &

wait #wait for the all the background processes to end

