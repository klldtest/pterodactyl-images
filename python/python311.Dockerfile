FROM python:3.11-rc-alpine

LABEL MAINTAINER Sahrul Arsad, sahrularsad@yewonkim.tk

RUN apk add --no-cache --update wget curl ca-certificates openssl git tar bash sqlite fontconfig neofetch
RUN apk add --no-cache --update build-base xz php8 ffmpeg

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
