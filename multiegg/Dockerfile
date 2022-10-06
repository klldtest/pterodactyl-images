# User latest alpine release
FROM alpine:latest

# Some label
LABEL MAINTAINER Sahrul Arsad, sahrularsad@yewonkim.tk

# Required packages
RUN apk add --no-cache --update curl wget ca-certificates coreutils

# Optional packages
RUN apk add --no-cache build-base git fontconfig xz tar unzip openssl libc6-compat gcompat bash ffmpeg

# Create user without password
RUN adduser --disabled-password --home /home/container container

# Change user to new user
USER container

# Set user and home location
ENV  USER=container HOME=/home/container

# Change dir to home directory
WORKDIR /home/container

# Copy entrypoint script into container
COPY ./entrypoint.sh /entrypoint.sh

# Copy install script into install
COPY ./script/install.sh /install.sh

# Copy main script into container
COPY ./script/main.sh /main.sh

# Copy note script into install
COPY ./script/note.sh /script/note.sh

# Copy node script into install
COPY ./script/node.sh /script/node.sh

# Copy python script into install
COPY ./script/python.sh /script/python.sh

# Copy java script into install
COPY ./script/java.sh /script/java.sh

# Copy github script into install
COPY ./script/github.sh /script/github.sh

# Copy shell script into install
COPY ./script/shell.sh /script/shell.sh

# Copy start script into install
COPY ./script/start.sh /script/start.sh

# Run script
ENTRYPOINT ["ash", "-l", "/entrypoint.sh"]