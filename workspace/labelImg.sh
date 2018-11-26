#!/bin/bash

cd ../Github/labelImg/
python labelImg.py ../../workspace/gym-images/ ../../workspace/predefined_classes.txt ../../workspace/gym-xmls
