FROM python:3.5
MAINTAINER frkhit "frkhit@gmail.com"
COPY ./requirements.txt ./
RUN apt update && apt install -y libopenblas-base libomp-dev && (cat requirements.txt | xargs -n 1 python -m pip install)
