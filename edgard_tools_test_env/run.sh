#!/bin/bash

# Edgard Lima <edgard.lima@gmail.com>

IMAGE=edgard_tools_env
CMD=bash

xhost +

# docker run --rm -it --device=/dev/nvidiactl --device=/dev/nvidia-uvm --device=/dev/nvidia0 -v nvidia_driver_384.111:/usr/local/nvidia:ro --name $IMAGE $IMAGE $CMD
docker run --rm -it --runtime=nvidia \
    --privileged \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -e DISPLAY=$DISPLAY \
    -e NVIDIA_VISIBLE_DEVICES=0 \
    -e NVIDIA_DRIVER_CAPABILITIES=compute,utility \
    -e LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/qt/5.10.1/gcc_64/lib:/opt/darknet \
    -e LIBRARY_PATH=$LIBRARY_PATH:/opt/qt/5.10.1/gcc_64/lib:/opt/darknet \
    -e PATH=/opt/qt/5.10.1/gcc_64/bin:$PATH \
    --device /dev/dri \
    --device /dev/snd \
    --device /dev/video0 \
    --name $IMAGE $IMAGE $CMD 

# http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/

