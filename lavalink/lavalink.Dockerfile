FROM openjdk:19-oracle

LABEL MAINTAINER Sahrul Arsad, sahrularsad@yewonkim.tk

RUN microdnf install curl ca-certificates openssl git tar bash sqlite fontconfig util-linux xz \
    && microdnf clean all \
    && adduser --disabled-password --home /home/container container

USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container

COPY ../entrypoint.sh /entrypoint.sh
COPY ../shell.sh /shell.sh
COPY ../lavalinkStart.sh /start.sh

CMD ["/bin/bash", "/entrypoint.sh"]
