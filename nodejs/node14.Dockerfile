FROM node:14-alpine

LABEL MAINTAINER Sahrul Arsad, sahrularsad@yewonkim.tk

ENV PYTHONUNBUFFERED=1

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk add --no-cache --update wget curl ca-certificates openssl git tar bash sqlite fontconfig neofetch
RUN apk add --no-cache --update build-base xz php8 python3 ffmpeg libffi-dev py3-libnacl opus opus-dev
RUN ln -sf python3 /usr/bin/python 
RUN python3 -m ensurepip 
RUN pip3 install --no-cache --upgrade pip setuptools 

RUN adduser --disabled-password --home /home/container container

USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container

COPY ./script/entrypoint.sh /entrypoint.sh
COPY ./script/node/nodeStart.sh /start.sh
COPY ./script/github.sh /github.sh
COPY ./script/shellv2.sh /shell.sh
COPY ./script/node/nodeAutoInstall.sh /nodeAutoInstall.sh

ENTRYPOINT ["/bin/bash", "-l","/entrypoint.sh"]
