#!/bin/sh

cd ./Github
git clone https://github.com/cocodataset/cocoapi.git
git clone https://github.com/tensorflow/models.git
sed -i 's/python /python3 /g' ./cocoapi/PythonAPI/Makefile

cd ../protoc
wget https://github.com/protocolbuffers/protobuf/releases/download/v3.0.0/protoc-3.0.0-linux-x86_64.zip
unzip ./protoc-3.0.0-linux-x86_64.zip

cd ..
docker-compose build