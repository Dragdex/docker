# License, please keep reference to this original docker and author then use it as you like 

ARG repository="nvidia/cuda"

FROM ${repository}:9.0-runtime-ubuntu17.04
LABEL maintainer "Edgard Lima <edgard.lima@gmail.com>"
# from https://gitlab.com/nvidia/cuda/blob/ubuntu17.04/9.0/devel/Dockerfile 

ADD res/sources.list /etc/apt/sources.list

RUN apt-get update && apt-get install -y --no-install-recommends \
        cuda-libraries-dev-$CUDA_PKG_VERSION \
        cuda-nvml-dev-$CUDA_PKG_VERSION \
        cuda-minimal-build-$CUDA_PKG_VERSION \
        cuda-command-line-tools-$CUDA_PKG_VERSION && \
    rm -rf /var/lib/apt/lists/*

# install opengl
RUN dpkg --add-architecture i386
ADD res/nvidia-driver.run /opt/nvidia-driver.run
RUN apt-get update && apt-get install -y mesa-utils module-init-tools
RUN chmod a+x /opt/nvidia-driver.run && \
    /opt/nvidia-driver.run -s -a -N --ui=none --no-kernel-module --opengl-headers


