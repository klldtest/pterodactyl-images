FROM openjdk:19-oracle

LABEL MAINTAINER Sahrul Arsad, sahrularsad@yewonkim.tk

RUN microdnf install epel-release
RUN rpm -i --nosignature "https://download1.rpmfusion.org/free/el/rpmfusion-free-release-8.noarch.rpm"
RUN rpm -i --nosignature "https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-8.noarch.rpm"
RUN if [[ "$(uname -m)" == "aarch64" ]] ; then rpm -i --nosignature "http://rpmfind.net/linux/epel/7/$(uname -m)/Packages/s/SDL2-2.0.10-1.el7.$(uname -m).rpm" ; elif [[ "$(uname -m)" == "x86_64" ]] ; then rpm -i --nosignature "http://rpmfind.net/linux/epel/7/$(uname -m)/Packages/s/SDL2-2.0.14-2.el7.$(uname -m).rpm" ; else rpm -i --nosignature "http://rpmfind.net/linux/epel/7/$(uname -m)/Packages/s/SDL2-2.0.10-1.el7.$(uname -m).rpm" ; fi
RUN microdnf install curl ca-certificates openssl git tar bash sqlite fontconfig hostname
RUN microdnf install xz python3 python3-pip jq neofetch opus ffmpeg ffmpeg-devel
RUN microdnf clean all 
RUN pip3 install yq 

RUN adduser --home-dir /home/container container

USER container
ENV USER=container HOME=/home/container

WORKDIR /home/container

COPY ./script/entrypoint.sh /entrypoint.sh
COPY ./script/shellv2.sh /shell.sh
COPY ./script/lavalink/lavalinkStart.sh /start.sh

USER root
RUN chmod a+x /entrypoint.sh
RUN chmod a+x /shell.sh
RUN chmod a+x /lavalinkStart.sh

USER container

CMD ["/bin/bash", "/entrypoint.sh"]
