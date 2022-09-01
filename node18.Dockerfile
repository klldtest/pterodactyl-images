FROM node:18-alpine

LABEL MAINTAINER Sahrul Arsad, sahrularsad@yewonkim.tk

FROM python:3.8-alpine as python
COPY --from=python /usr/local/bin/python3 /usr/local/bin/python3
COPY --from=python /usr/local/lib/python3.8 /usr/local/lib/python3.8
COPY --from=python /usr/local/lib/libpython3.8.so.1.0 /usr/local/lib/libpython3.8.so.1.0
COPY --from=python /usr/local/lib/libpython3.so /usr/local/lib/libpython3.so

RUN apk add --no-cache --update curl ca-certificates openssl git tar bash sqlite fontconfig util-linux xz php8 \
    && pip3 install --no-cache --upgrade pip setuptools \
    && adduser --disabled-password --home /home/container container

USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
COPY ./shell.sh /shell.sh
COPY ./nodeStart.sh /start.sh

CMD ["/bin/bash", "/entrypoint.sh"]
