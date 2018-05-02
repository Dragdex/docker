To build this docker takes a while. Because of that, I do recommend to first  test your enviroment with  ../edgard_tools_test_env

Once you have everything working there, come back here and continue

##############################################################

install nvidia-docker2 on host machine

make sure you have nvidia drivers working on host machine

    nvidia-smi

should output [../edgard_tools_test_env/res/nvidia-smi_host-output.png](https://github.com/Dragdex/docker/blob/master/edgard_tools_test_env/res/nvidia-smi_host-output.png)

#######################################################################

# Build your image

- Generate the base Dockerfile

    ./bootstrap.sh

- Optionally add ngix, extra image tools and yolo weights

    cat docker_include/nginx.docker >> Dockerfile
    
    cat docker_include/img-extra.docker >> Dockerfile
    
    cat docker_include/darknet-weights.docker >> Dockerfile

- if you do not want to download yolo weights, build it with

    ./build.sh --no-yolo-weights

- or else build it with

(depends on "cat docker_include/darknet-weights.docker >> Dockerfile")

    ./build.sh

#######################################################################

# check the build

- execute

    ./run.sh --no-port

- into the docker

    nvidia-smi

should output [../edgard_tools_test_env/res/nvidia-smi_docker-output.png](https://github.com/Dragdex/docker/blob/master/edgard_tools_test_env/res/nvidia-smi_docker-output.png)

#######################################################################

# run

- to run bash prompt

    ./run.sh

- to run bash prompt without mapping ports

    ./run.sh --no-port

- to execute a command direclty

    RUN_CMD="(ls -la ; date )" ./run.sh
    
- to open bash with nginx running in background    
    
    RUN_CMD="(/usr/local/nginx/sbin/nginx ; date & bach)" ./run.sh

#######################################################################
 
# check if darknet is working

- execute into the docker

    cd /opt/darknet && ./darknet -i 0 detector demo cfg/coco.data cfg/yolo.cfg yolov2.weights

#######################################################################

# test nginx with

Playback with:

- into the docker

    gst-launch-1.0 -v playbin uri="rtmp://localhost/live/drone" live=1 is-live=true latency=50 sync=false

or opitionally with

    apt-get install ffmpeg

ffplay -fflags nobuffer rtmp://127.0.0.1/live/drone -loglevel verbose

- in host machine

    ffmpeg -f v4l2 -framerate 15 -video_size 800x600 -i /dev/video0 -video_size 800x600 -vcodec libx264 -maxrate 768k -bufsize 8080k -tune zerolatency -vf "format=yuv420p" -movflags +faststart -preset ultrafast -r 15 -vf scale=800:600 -f flv rtmp://localhost/live/drone

#######################################################################
