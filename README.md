# MBZIRC2020

Sant'Anna team drone for the MBZIRC 2020 challenge 

## Installation

### Basic dependencies
```
sudo apt install build-essential python-dev python-pip
sudo apt install cmake git mercurial
```

### Install ROS

```
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
sudo apt update
sudo apt install ros-melodic-desktop-full
sudo rosdep init
rosdep update
echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
source ~/.bashrc
```

#### Install some ROS packages
```
sudo apt install python-rosinstall python-rosinstall-generator python-wstool python-catkin-tools
sudo apt install ros-melodic-octomap-ros
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


### Ardupilot

Now you have to install Ardupilot in a directory of your choice, let's say the home:
```
cd ~
git clone --recurse-submodules https://github.com/ArduPilot/ardupilot
cd ardupilot
chmod a+x Tools/environment_install/install-prereqs-ubuntu.sh
Tools/environment_install/install-prereqs-ubuntu.sh -y
source ~/.profile
```

#### (Optional) Test Ardupilot

If you want to verify that your Ardupilot installation was successful:

```
cd ArduCopter
sim_vehicle.py -j4 --map --console
```
And in the terminal type:
```
mode GUIDED
arm throttle
takeoff 100 
```

### Download Gazebo DB

The next step is to install the predefined models of Gazebo. Feel free to choose the directory where to do so (e.g. the home):
```
cd ~
hg clone https://bitbucket.org/osrf/gazebo_models
cd gazebo_models
hg checkout zephyr_demos
echo "export GAZEBO_MODEL_PATH=${GAZEBO_MODEL_PATH}:$PWD" >> ~/.bash_mbzirc
source ~/.bashrc
```

### Initialize and configure catkin workspace

It's now time to prepare the actual ROS workspace for our drone. 

| WARNING: not all the required submodules are publicly released, so you need to ask for pemissions to the respective authors. Please contact @leoll2 for more details. |
| --- |

First of all, clone this repo. You can do it in any folder, we suggest the home.
```
mkdir drone_ws
cd drone_ws
git clone --recurse-submodules https://github.com/leoll2/MBZIRC2020.git src
```

Checkout to the correct branch of the vision module:
```
cd MBZIRC2020/mbzirc_vision/MBZIRC2020Vision/
git checkout ros_integrated
cd -
```

Now build all the ROS modules:
```
catkin build
source devel/setup.bash
```
If you don't want to source ```devel/setup.bash``` on every terminal opening, just
```
echo "source $PWD/devel/setup.bash" >> ~/.bash_mbzirc
```

> **Tip**: if you clone the repository by https, then for pushing/pulling you will be prompted to insert github username and pass every single time; to avoid this, you may use SSH to clone the repository (`git@github.com:leoll2/MBZIRC2020.git`), and add the ssh key to your local pc and github account. Obviously, you can always copy the repo via https and add the ssh remote later.|

Create links to Ardupilot and gazebo models folders (not strictly necessary, but handy):
```
ln -s <path/to/ardupilot> src/ardupilot
ln -s <path/to/gazebo/models> src/gazebo_models
```

Add environment variables:
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

### Test Gazebo + Ardupilot

Now go back to the `ardupilot` directory:
```
cd ArduCopter
sim_vehicle.py --console -f gazebo-MBZIRColo
```
Move to `catkin_ws\src\mbzirc_gazebo`, then:
```
gazebo --verbose gazebo_worlds/drone_plus_env.world
```

-------
## START THE SIMULATION FRAMEWORK
###### Gazebo
First, start gazebo (+ ardupilot), having in mind the fact that gazebo is saving images on the file system.
Refer to mbzirc_gazebo repo
###### Vision
Secondly, start the image processing part.
Refer to MBZRIC2020Vision repo (inside the mbzirc_vision repo, this last one being in this repo)
