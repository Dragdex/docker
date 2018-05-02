

install nvidia-docker2 on host machine

make sure you have nvidia drivers working on host machine

    nvidia-smi

should output a table like format with the driver version

./build.sh to build the docker image

./run.sh to execute the docker image

to check if the docker is working execute into the docker

    nvidia-smi

	should print something like in res/nvidia-smi-output.png

	glxgears

	should print something like in res/glxgears-output.png


######################################

Now you can go back to ../edgard_tools and build it

you can copy ./edgard_tools_env/nvidia-driver.run to ./edgard_tools/nvidia-driver.run to speedup a little bit the build there

