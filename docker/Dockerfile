ARG ROS_DISTRO=humble

FROM arm64v8/ros:${ROS_DISTRO}-ros-core as base
ENV ROS_DISTRO=${ROS_DISTRO}
SHELL ["/bin/bash", "-c"]
ENV DEBIAN_FRONTEND=noninteractive


RUN apt-get update && apt-get install -y \
	libcamera-dev
RUN apt-get update && apt-get install -y \
	ros-${ROS_DISTRO}-camera-ros 

RUN apt-get update && apt-get install -y \
	ros-${ROS_DISTRO}-libcamera
RUN apt-get update && apt-get install -y \
	v4l-utils

RUN usermod -a -G video root
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc

RUN mkdir -p /workspace/src
WORKDIR /workspace

