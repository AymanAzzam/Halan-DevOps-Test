FROM ubuntu:16.04

LABEL maintainer="Ayman Azzam aymanazzam63@gmail.com"

WORKDIR /app

COPY . /app

RUN apt-get update -y && apt-get install -y python-pip python-dev libpq-dev

RUN pip install -r requirements.txt