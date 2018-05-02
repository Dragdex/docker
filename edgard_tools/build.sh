#!/bin/bash

# Edgard Lima <edgard.lima@gmail.com>

IMAGE=edgard_tools

# download cudnn
CUDNN_URL="http://developer.download.nvidia.com/compute/redist/cudnn/v7.1.3/cudnn-9.0-linux-x64-v7.1.tgz"
( wget --max-redirect=9 -c $CUDNN_URL -O res/cudnn-9.0-linux-x64-v7.1.tgz ) || { echo "failed to download cudnn" ; exit; }

# download qt installer
QT_URL="https://download.qt.io/official_releases/qt/5.10/5.10.1/qt-opensource-linux-x64-5.10.1.run"
( wget --max-redirect=9 -c $QT_URL -O res/qt_installer.run ) || { echo "failed to download qt-installer" ; exit; }

# download nvidia driver
nvidia_version=$(cat /proc/driver/nvidia/version | head -n 1 | awk '{ print $8 }')
nvidia_driver_uri=http://us.download.nvidia.com/XFree86/Linux-x86_64/${nvidia_version}/NVIDIA-Linux-x86_64-${nvidia_version}.run
( wget --max-redirect=9 -c $nvidia_driver_uri -O res/nvidia-driver.run ) || { echo "failed to nvidia-driver" ; exit; }

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
	( wget --max-redirect=9 -c https://pjreddie.com/media/files/yolov2.weights -O res/yolov2.weights ) || { echo "failed to download yolov2.weights" ; exit; }
	( wget --max-redirect=9 -c https://pjreddie.com/media/files/yolov2-voc.weights -O res/yolov2-voc.weights ) || { echo "failed to download yolov2-voc.weights" ; exit; }
	( wget --max-redirect=9 -c https://pjreddie.com/media/files/yolov2-tiny.weights -O res/yolov2-tiny.weights ) || { echo "failed to download yolov2-tiny.weights" ; exit; }
	( wget --max-redirect=9 -c https://pjreddie.com/media/files/yolov2-tiny-voc.weights -O res/yolov2-tiny-voc.weights ) || { echo "failed to download yolov2-tiny-voc.weight" ; exit; }
fi

docker build -t $IMAGE .

