#!/bin/bash
# Basic entrypoint for ROS / Colcon Docker containers
 
# Source ROS 2
source /opt/ros/${ROS_DISTRO}/setup.bash
echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> /root/.bashrc

# Source the base workspace, if built
if [ -f /drivers_ws/install/setup.bash ]
then
  source /drivers_ws/install/setup.bash
  echo "source /drivers_ws/install/setup.bash" >> /root/.bashrc
fi
 
# Source the overlay workspace, if built
if [ -f /workspace/install/setup.bash ]
then
  source /workspace/install/setup.bash
  echo "source /workspace/install/setup.bash" >> /root/.bashrc
fi
 
# Execute the command passed into this entrypoint
exec "$@"