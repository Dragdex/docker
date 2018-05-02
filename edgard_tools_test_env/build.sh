#!/bin/bash

# Edgard Lima <edgard.lima@gmail.com>

IMAGE=edgard_tools_env

# download nvidia driver
nvidia_version=$(cat /proc/driver/nvidia/version | head -n 1 | awk '{ print $8 }')
nvidia_driver_uri=http://us.download.nvidia.com/XFree86/Linux-x86_64/${nvidia_version}/NVIDIA-Linux-x86_64-${nvidia_version}.run
( wget --max-redirect=9 -c $nvidia_driver_uri -O res/nvidia-driver.run ) || { echo "failed to nvidia-driver" ; exit; }

docker build -t $IMAGE .

