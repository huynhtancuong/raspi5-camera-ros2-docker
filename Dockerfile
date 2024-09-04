FROM arm64v8/ros:noetic-perception

# RVIZ setup
RUN apt-get update \
 && apt-get install -y \
 ros-noetic-rviz 

RUN sudo sh \
    -c 'echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" \
    > /etc/apt/sources.list.d/ros-latest.list'
RUN wget http://packages.ros.org/ros.key -O - | sudo apt-key add -

RUN apt-get update \
    && apt-get install -y \
    python3-catkin-tools 

RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc