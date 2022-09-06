FROM openjdk:19-oracle

LABEL MAINTAINER Sahrul Arsad, sahrularsad@yewonkim.tk

RUN microdnf install curl ca-certificates openssl git tar bash sqlite fontconfig util-linux xz python38 jq \
    && microdnf clean all \
    && pip install yq \
    && adduser --home-dir /home/container container

USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container

COPY ../script/entrypoint.sh /entrypoint.sh
COPY ../script/shell.sh /shell.sh
COPY ../script/lavalinkStart.sh /start.sh

CMD ["/bin/bash", "/entrypoint.sh"]
