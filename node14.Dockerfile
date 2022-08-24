FROM node:14-alpine

LABEL MAINTAINER Sahrul Arsad, sahrularsad@yewonkim.tk

RUN apk add --no-cache --update curl ca-certificates openssl git tar bash sqlite fontconfig util-linux xz \
    && adduser --disabled-password --home /home/container container

USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
COPY ./shell.sh /shell.sh
COPY ./nodeStart.sh /start.sh

CMD ["/bin/bash", "/entrypoint.sh"]
