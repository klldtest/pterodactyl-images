FROM node:16-alpine

LABEL MAINTAINER Sahrul Arsad, sahrularsad@yewonkim.tk

ENV PYTHONUNBUFFERED=1
RUN apk add --no-cache --update build-base curl ca-certificates openssl git tar bash sqlite fontconfig util-linux xz php8 python3 \
    && ln -sf python3 /usr/bin/python \
    && python3 -m ensurepip \
    && pip3 install --no-cache --upgrade pip setuptools \
    && adduser --disabled-password --home /home/container container

USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
COPY ./shell.sh /shell.sh
COPY ./nodeStart.sh /start.sh

CMD ["/bin/bash", "/entrypoint.sh"]
