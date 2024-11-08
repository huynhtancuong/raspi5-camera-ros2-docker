#!/bin/bash

xhost +

docker run \
    -it -d --rm --net=host --privileged \
    --name "my_ros2_container" \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    -e XAUTHORITY \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --volume="${PWD}/workspace":"/workspace":rw \
    -v /dev:/dev \
    -v /run/udev:/run/udev:ro \
    my_humble \
    bash
