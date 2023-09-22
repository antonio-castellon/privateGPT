FROM ubuntu:22.04
RUN     apt-get update && \
        apt-get dist-upgrade -y
RUN     apt-get install -y python3-pip

# include drivers from CUDA
RUN     apt-get install -y software-properties-common
RUN     apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/7fa2af80.pub
RUN     add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/ /"
RUN     apt-get update
RUN     apt upgrade
RUN     apt install -y cuda-drivers-fabricmanager-535

# tools

RUN     apt-get install -y less rsync vim nano tree file wget

ADD     . /.
WORKDIR /.

RUN 	CMAKE_ARGS="-DLLAMA_CUBLAS=on" FORCE_CMAKE=1 pip3 install llama-cpp-python torch torchvision torchaudio transformers --force-reinstall --upgrade --no-cache-dir
RUN     CMAKE_ARGS="-DLLAMA_CUBLAS=on" FORCE_CMAKE=1 pip3 install -r requirements.txt --force-reinstall --upgrade --no-cache-dir; find /root/.cache/pip/ -type f -delete

RUN     mv example.gpu.env .env

VOLUME /models

# RUN     python3 ingest.py

