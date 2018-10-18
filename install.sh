#!/bin/bash

if [ ! -d "Github" ]; then
    mkdir Github
fi

if [ ! -d "Github/labelImg" ]; then
    cd Github
    git clone https://github.com/tzutalin/labelImg.git
    apt-get install pyqt5-dev-tools -y
    cd labelImg
    pip3 install -r requirements/requirements-linux-python3.txt
    make qt5py3
    cd ../..
fi
