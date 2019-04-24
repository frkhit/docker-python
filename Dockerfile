FROM python:3.5
MAINTAINER frkhit "frkhit@gmail.com"
COPY ./requirements.txt ./
RUN apt-get update && \
    apt-get install -y libopenblas-base libomp-dev python-dev && \
    pip install -r requirements.txt
RUN pip install pyltp py2neo==3.1.2

