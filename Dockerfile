FROM guiym/objectdetection:latest

RUN apt-get install poppler-utils -y
RUN pip3 install pdf2image

