FROM nvidia/cuda:9.0-cudnn7-runtime-ubuntu16.04

RUN apt-get update
RUN apt-get -y upgrade

RUN apt-get install -y build-essential libssl-dev libffi-dev python3-dev python3 python3-pip wget unzip
RUN pip3 install --upgrade pip
# RUN pip3 install --upgrade tensorflow-gpu==1.8
RUN pip3 install tensorflow-gpu

RUN apt-get install -y python-pil python-lxml python-tk
RUN pip3 install Cython
RUN pip3 install numpy
RUN pip3 install contextlib2
RUN pip3 install jupyter
RUN pip3 install matplotlib
RUN pip3 install setuptools
RUN pip3 install image
RUN pip3 install 'prompt-toolkit==2.0.4'

RUN mkdir -p /usr/src/ObjectDetection
WORKDIR /usr/src/ObjectDetection

COPY Github $HOME

RUN cd cocoapi/PythonAPI && make
RUN cp -r cocoapi/PythonAPI/pycocotools models/research/

COPY /protoc/ models/research/
RUN cd models/research && ./bin/protoc object_detection/protos/*.proto --python_out=.

ENV PYTHONPATH /usr/src/ObjectDetection/models/research:/usr/src/ObjectDetection/models/research/slim

EXPOSE 8888

CMD jupyter notebook --port=8888 --no-browser --ip=0.0.0.0 --allow-root