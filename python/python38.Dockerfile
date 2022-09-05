FROM python:3.8-alpine

LABEL MAINTAINER Sahrul Arsad, sahrularsad@yewonkim.tk

RUN apk add --no-cache --update build-base curl ca-certificates openssl git tar bash sqlite fontconfig util-linux xz php8 \
    && adduser --disabled-password --home /home/container container

USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container

COPY ../script/entrypoint.sh /entrypoint.sh
COPY ../script/shell.sh /shell.sh
COPY ../script/pythonStart.sh /start.sh

CMD ["/bin/bash", "/entrypoint.sh"]
