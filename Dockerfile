FROM tensorflow/tensorflow:nightly-devel-gpu-py3

ARG path=/usr/src/object_detection

# RUN apt-get update
# RUN apt-get -y upgrade

# RUN apt-get install -y build-essential libssl-dev libffi-dev python3-dev python3 python3-pip wget unzip
# RUN pip3 install --upgrade pip
# # RUN pip3 install --upgrade tensorflow-gpu==1.8
RUN pip3 install --upgrade tensorflow-gpu==1.9

# RUN apt-get install -y python-pil python-lxml python-tk
RUN pip3 install Cython
# RUN pip3 install numpy
RUN pip3 install contextlib2
# RUN pip3 install jupyter
# RUN pip3 install matplotlib
# RUN pip3 install setuptools
RUN pip3 install image
RUN pip3 install 'prompt-toolkit==2.0.4'


RUN mkdir -p $path
WORKDIR $path

COPY Github $path

RUN cd cocoapi/PythonAPI && make
RUN cp -r cocoapi/PythonAPI/pycocotools models/research/

COPY /protoc/ models/research/
RUN cd models/research && ./bin/protoc object_detection/protos/*.proto --python_out=.

ENV PYTHONPATH $path/models/research:$path/models/research/slim

EXPOSE 8888

CMD jupyter notebook --port=8888 --no-browser --ip=0.0.0.0 --allow-root