FROM python:3.9-alpine

LABEL MAINTAINER Sahrul Arsad, sahrularsad@yewonkim.tk

RUN apk add --no-cache --update wget curl ca-certificates openssl git tar bash sqlite fontconfig neofetch
RUN apk add --no-cache --update build-base xz php8 ffmpeg

RUN adduser --disabled-password --home /home/container -u 995 container

USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container

COPY ../script/entrypoint.sh /entrypoint.sh
COPY ../script/shell.sh /shell.sh
COPY ../script/pythonStart.sh /start.sh

CMD ["/bin/bash", "/entrypoint.sh"]
