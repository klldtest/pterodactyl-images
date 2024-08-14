FROM python:3.9-alpine

LABEL MAINTAINER=Sahrul Arsad, yewonkim@live.sah.ovh
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk add --no-cache --update wget curl ca-certificates openssl git tar bash sqlite fontconfig neofetch
RUN apk add --no-cache --update build-base xz php81 ffmpeg libffi-dev py3-libnacl opus opus-dev

RUN adduser --disabled-password --home /home/container container

USER container
ENV USER=container HOME=/home/container

WORKDIR /home/container

COPY ./script/entrypoint.sh /entrypoint.sh
COPY ./script/python/pythonStart.sh /start.sh
COPY ./script/github.sh /github.sh
COPY ./script/shellv2.sh /shell.sh
COPY ./script/python/pythonAutoInstall.sh /pythonAutoInstall.sh
COPY ./script/info/* /

USER root
RUN chmod a+x /*.sh

USER container

CMD ["/bin/bash", "/entrypoint.sh"]
