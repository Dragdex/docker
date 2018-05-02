#!/bin/bash

# Edgard Lima <edgard.lima@gmail.com>

IMAGE=edgard_tools_env

# download nvidia driver
nvidia_version=$(cat /proc/driver/nvidia/version | head -n 1 | awk '{ print $8 }')
nvidia_driver_uri=http://us.download.nvidia.com/XFree86/Linux-x86_64/${nvidia_version}/NVIDIA-Linux-x86_64-${nvidia_version}.run
( curl -Lo res/nvidia-driver.run -C - $nvidia_driver_uri ) || echo "failed to download nvidia driver" ; exit

docker build -t $IMAGE .

