#!/bin/bash

# Edgard Lima <edgard.lima@gmail.com>

IMAGE=edgard_tools

if [ "$RUN_CMD" == "" ]; then
    RUN_CMD=bash
fi

# CMD="(/usr/local/nginx/sbin/nginx ; /opt/cockpit/integrator/integrator.py & /opt/cockpit/build/cockpit /opt/cockpit/deploy/configs/default_rec.info)"

xhost +

PORT_FW="-p 1935:1935"

while test $# -gt 0
do
    case "$1" in
        --no-port) PORT_FW="" 
            ;;
        --*) echo "bad option $1"
            ;;
        *) echo "argument $1 unknown"
            ;;
    esac
    shift
done

# docker run --rm -it --device=/dev/nvidiactl --device=/dev/nvidia-uvm --device=/dev/nvidia0 -v nvidia_driver_384.111:/usr/local/nvidia:ro --name $IMAGE $IMAGE $CMD
docker run --rm -it --runtime=nvidia \
    $PORT_FW \
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
    --name $IMAGE $IMAGE bash -c "$RUN_CMD" 

# http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/

