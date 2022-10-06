FROM openjdk:19-oracle

LABEL MAINTAINER Sahrul Arsad, sahrularsad@yewonkim.tk

RUN microdnf install curl ca-certificates openssl git tar bash sqlite fontconfig 
RUN microdnf install xz python3 python3-pip jq neofetch
RUN microdnf clean all 
RUN pip3 install yq 

RUN adduser --home-dir /home/container -u 995 container

USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container

COPY ../script/entrypoint.sh /entrypoint.sh
COPY ../script/shellv2.sh /shell.sh
COPY ../script/lavalink/lavalinkStart.sh /start.sh

CMD ["/bin/bash", "/entrypoint.sh"]
