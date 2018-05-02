#!/bin/bash

# Edgard Lima <edgard.lima@gmail.com>

IMAGE=edgard_tools

# download cudnn
CUDNN_URL="http://developer.download.nvidia.com/compute/redist/cudnn/v7.1.3/cudnn-9.0-linux-x64-v7.1.tgz"
( curl -Lo res/cudnn-9.0-linux-x64-v7.1.tgz -C - $CUDNN_URL ) || echo "failed to download cudnn" ; exit

# download qt installer
QT_URL="https://download.qt.io/official_releases/qt/5.10/5.10.1/qt-opensource-linux-x64-5.10.1.run"
( curl -Lo res/qt_installer.run -C - $QT_URL ) || echo "failed to download qt" ; exit

# download nvidia driver
nvidia_version=$(cat /proc/driver/nvidia/version | head -n 1 | awk '{ print $8 }')
nvidia_driver_uri=http://us.download.nvidia.com/XFree86/Linux-x86_64/${nvidia_version}/NVIDIA-Linux-x86_64-${nvidia_version}.run
( curl -Lo res/nvidia-driver.run -C - $nvidia_driver_uri ) || echo "failed to download driver" ; exit

YOLO_WEIGHTS="y"

while test $# -gt 0
do
    case "$1" in
        --no-yolo-weights) YOLO_WEIGHTS="" 
            ;;
        --*) echo "bad option $1"
            ;;
        *) echo "argument $1 unknown"
            ;;
    esac
    shift
done

# download yolo weights
if [ "$YOLO_WEIGHTS" == "y" ]; then
    ( curl -Lo res/yolov2.weights -C - https://pjreddie.com/media/files/yolov2.weights ) || echo "failed to download yolo2" ; exit
    ( curl -Lo res/yolov2-voc.weights -C - https://pjreddie.com/media/files/yolov2-voc.weights ) || echo "failed to download yolo2voc" ; exit
    ( curl -Lo res/yolov2-tiny.weights -C - https://pjreddie.com/media/files/yolov2-tiny.weights ) || echo "failed to download yolo2tiny" ; exit
    ( curl -Lo res/yolov2-tiny-voc.weights -C - https://pjreddie.com/media/files/yolov2-tiny-voc.weights ) || echo "failed to download yolo2tiny-voc" ; exit
fi

docker build -t $IMAGE .

