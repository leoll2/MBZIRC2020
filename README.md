# MBZIRC2020
Drone of the Sant'Anna team for the MBZIRC 2020 challenge 

## Installation

### Dependencies

```
TODO
sudo apt install ros-melodic-mavros ros-melodic-mavros-extras
```

### Prepare files to store env variables

```
cd ~
touch .bash_mbzirc
```

Open the file `.bashrc` and append the following lines:
```
if [ -f ~/.bash_mbzirc ]; then
    . ~/.bash_mbzirc
fi
```

### Add ROS env variable
```
echo "source /opt/ros/melodic/setup.bash" >> ~/.bash_mbzirc
source ~/.bashrc
```

### Ardupilot

```
TODO
```

### (Optional) Test Ardupilot

```
TODO
```

### Download Gazebo DB

```
TODO
```

### Initialize and configure catkin workspace

```
mkdir catkin_ws
cd catkin_ws
git clone --recurse-submodules https://github.com/leoll2/MBZIRC2020.git src
catkin build
source devel/setup.bash
```

```
echo "export GAZEBO_MODEL_PATH=\${GAZEBO_MODEL_PATH}:$(rospack find mbzirc_sitl)/gazebo_models" >> ~/.bash_mbzirc
echo "export GAZEBO_PLUGIN_PATH=\${GAZEBO_PLUGIN_PATH}:$(catkin locate)/build/mbzirc_sitl" >> ~/.bash_mbzirc
echo "export GAZEBO_PLUGIN_PATH=\${GAZEBO_PLUGIN_PATH}:/usr/lib/x86_64-linux-gnu/gazebo-9/plugins/" >> ~/.bash_mbzirc
source ~/.bashrc
```
