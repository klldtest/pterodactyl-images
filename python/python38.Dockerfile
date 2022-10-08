FROM python:3.8-alpine

LABEL MAINTAINER Sahrul Arsad, sahrularsad@yewonkim.tk

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk add --no-cache --update wget curl ca-certificates openssl git tar bash sqlite fontconfig neofetch
RUN apk add --no-cache --update build-base xz php8 ffmpeg libffi-dev py3-libnacl opus opus-dev

RUN adduser --disabled-password --home /home/container -u 995 container

USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container

COPY ../script/entrypoint.sh /entrypoint.sh
COPY ../script/python/pythonStart.sh /start.sh
COPY ../script/github.sh /github.sh
COPY ../script/shellv2.sh /shell.sh
COPY ../script/python/pythonAutoInstall.sh /pythonAutoInstall.sh

CMD ["/bin/bash", "/entrypoint.sh"]
