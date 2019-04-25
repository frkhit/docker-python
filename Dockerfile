FROM python:3.6
MAINTAINER frkhit "frkhit@gmail.com"
COPY ./requirements.txt ./
RUN apt-get update && \
    apt-get install -y libopenblas-base libomp-dev python-dev && \
    pip install -r requirements.txt && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /root/.cache/pip/*
