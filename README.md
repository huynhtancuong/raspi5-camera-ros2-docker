### Template for running ROS in Docker

You can modify the Dockerfile 
Then you can use these commands to buid, run, connect to the container, and finally stop it.
```
bash docker/build.bash
bash docker/run.bash
bash docker/into.bash
bash docker/stop.bash
```

When inside the container, you can bringup the camera by using
```
ros2 run camera_ros camera_node --ros-args -p camera:=0  -p role:=video -p format:=UYVY -p width:=1640 -p height:=1232 -p FrameDurationLimits:="[30000,30000]"
```