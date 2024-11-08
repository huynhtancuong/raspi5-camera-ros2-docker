ARG ROS_DISTRO=humble

###################
# Base(driver) workspace
###################
FROM arm64v8/ros:${ROS_DISTRO}-perception AS base
ENV ROS_DISTRO=${ROS_DISTRO}
SHELL ["/bin/bash", "-c"]
ENV DEBIAN_FRONTEND=noninteractive

# Install libcamera
RUN apt-get update 
RUN apt-get install -y python3-pip git python3-jinja2
RUN apt-get install -y \
	libboost-dev \
	libgnutls28-dev openssl libtiff5-dev pybind11-dev \
	qtbase5-dev libqt5core5a libqt5gui5 libqt5widgets5 \
	meson cmake \
	python3-yaml python3-ply \
	libglib2.0-dev libgstreamer-plugins-base1.0-dev

RUN mkdir /drivers && cd /drivers && git clone https://github.com/raspberrypi/libcamera.git
WORKDIR /drivers/libcamera
RUN pip install --force-reinstall -v "meson==0.63"
RUN meson setup build --buildtype=release -Dpipelines=rpi/vc4,rpi/pisp -Dipas=rpi/vc4,rpi/pisp -Dv4l2=true -Dgstreamer=enabled -Dtest=false -Dlc-compliance=disabled -Dcam=disabled -Dqcam=disabled -Ddocumentation=disabled -Dpycamera=enabled
RUN ninja -C build
RUN ninja -C build install

# Install rpicam-apps
RUN mkdir -p /drivers/rpicam-apps
RUN apt install -y cmake libboost-program-options-dev libdrm-dev libexif-dev
RUN apt install -y ninja-build
RUN pip install --force-reinstall -v "meson==0.64"
RUN apt install -y libavdevice-dev 
RUN apt install -y libepoxy-dev libjpeg-dev libtiff5-dev libpng-dev
RUN git clone https://github.com/raspberrypi/rpicam-apps.git /drivers/rpicam-apps
WORKDIR /drivers/rpicam-apps
RUN meson setup build -Denable_libav=enabled -Denable_drm=enabled -Denable_egl=enabled -Denable_qt=enabled -Denable_opencv=disabled -Denable_tflite=disabled -Denable_hailo=disabled
RUN meson compile -C build
RUN meson install -C build

# Driver workspace
RUN mkdir -p /drivers_ws/src
WORKDIR /drivers_ws
RUN git clone https://github.com/christianrauch/camera_ros.git src/camera_ros
RUN source /opt/ros/${ROS_DISTRO}/setup.bash \
	&& rosdep install --from-paths src --ignore-src -r -y --skip-keys=libcamera\
	&& colcon build 

# Post installation
RUN usermod -a -G video root

###################
# Overlay workspace
###################
FROM base AS overlay

# Create an overlay colcon workspace
RUN mkdir -p /workspace/src
WORKDIR /workspace
RUN source /drivers_ws/install/setup.bash \
	&& rosdep install --from-paths src --ignore-src --rosdistro ${ROS_DISTRO} -y \
	&& colcon build

# Set up the entrypoint
COPY ./docker/entrypoint.sh /
ENTRYPOINT [ "/entrypoint.sh" ]



