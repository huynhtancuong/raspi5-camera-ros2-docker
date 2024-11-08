# docker build -f docker/Dockerfile \
# 	--build-arg="ROS_DISTRO=humble" \
# 	--target base -t my_humble:base . 

docker build -f docker/Dockerfile \
	--build-arg="ROS_DISTRO=humble" \
	--target overlay -t my_humble . 
