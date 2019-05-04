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
echo "export GAZEBO_MODEL_PATH=\${GAZEBO_MODEL_PATH}:$(catkin locate)/src/gazebo_models" >> ~/.bash_mbzirc
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
echo "export GAZEBO_MODEL_PATH=\${GAZEBO_MODEL_PATH}:$(rospack find mbzirc_gazebo)/gazebo_models" >> ~/.bash_mbzirc
echo "export GAZEBO_PLUGIN_PATH=\${GAZEBO_PLUGIN_PATH}:$(catkin locate)/build/mbzirc_gazebo" >> ~/.bash_mbzirc
echo "export GAZEBO_PLUGIN_PATH=\${GAZEBO_PLUGIN_PATH}:/usr/lib/x86_64-linux-gnu/gazebo-9/plugins/" >> ~/.bash_mbzirc
source ~/.bashrc
```

### Add our vehicle parameters to Ardupilot
```
mkdir src/ardupilot/Tools/autotest/MBZIRC_params
cp src/mbzirc_gazebo/ardupilotStuff/MBZIRC-provaParams/gazebo-MBZIRColo.parm src/ardupilot/Tools/autotest/MBZIRC_params
```
Now edit `src/ardupilot/Tools/autotest/pysim/vehicleinfo.py`, adding below

```
"gazebo-iris": {
  "waf_target": "bin/arducopter",
  "default_params_filename": ["default_params/copter.parm",
                              "default_params/gazebo-iris.parm"],
},
```
the following item to the dictionary:
```
# MBZIRColo
"gazebo-MBZIRColo":{
    "waf_target": "bin/arducopter",
    "default_params_filename":["default_params/copter.parm",
                                "MBZIRC_params/gazebo-MBZIRColo.parm"],
},
```
Now go back to the `ardupilot` directory:
```
cd ArduCopter
sim_vehicle.py --console -f gazebo-MBZIRColo
```
