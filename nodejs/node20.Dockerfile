FROM node:20-alpine

LABEL MAINTAINER="Sahrul Arsad, yewonkim@live.sah.ovh"

ENV PYTHONUNBUFFERED=1 PNPM_HOME=/pnpm

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk add --no-cache --update wget curl ca-certificates openssl git tar bash sqlite fontconfig neofetch
RUN apk add --no-cache --update build-base xz php81 python3 py3-pip py3-setuptools ffmpeg libffi-dev py3-libnacl opus opus-dev pixman-dev cairo-dev pango-dev
RUN ln -sf python3 /usr/bin/python 
RUN ln -s $(which php81) /usr/bin/php
RUN wget -qO- https://get.pnpm.io/install.sh | SHELL="$(which bash)" bash -

RUN adduser --disabled-password --home /home/container container

USER container
ENV USER=container HOME=/home/container

WORKDIR /home/container

COPY ./script/entrypoint.sh /entrypoint.sh
COPY ./script/node/nodeStart.sh /start.sh
COPY ./script/github.sh /github.sh
COPY ./script/shellv2.sh /shell.sh
COPY ./script/node/nodeAutoInstall.sh /nodeAutoInstall.sh
COPY ./script/info/* /

USER root
RUN chmod a+x /*.sh

USER container

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
