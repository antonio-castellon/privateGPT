FROM ubuntu:22.04
RUN apt-get update && \
    apt-get dist-upgrade -y
RUN apt-get install -y \
      python3-pip \
      wget \
      ;

# include some tools for the interactive container
RUN     apt-get install -y less rsync vim nano tree file

ADD     . /.
WORKDIR /.
RUN 	CMAKE_ARGS="-DLLAMA_CUBLAS=on" FORCE_CMAKE=1 pip3 install llama-cpp-python torch torchvision torchaudio transformers --force-reinstall --upgrade --no-cache-dir
RUN     CMAKE_ARGS="-DLLAMA_CUBLAS=on" FORCE_CMAKE=1 pip3 install -r requirements.txt --force-reinstall --upgrade --no-cache-dir; find /root/.cache/pip/ -type f -delete

RUN     mv example.gpu.env .env

VOLUME /models

# RUN     python3 ingest.py

