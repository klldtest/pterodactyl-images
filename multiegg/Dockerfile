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

# Create .profile
RUN echo '' > $HOME/.profile
# Install Node Version Manager
RUN wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | ash

# Install Python Version Manager
RUN curl https://pyenv.run | ash
# Load into .profile
RUN echo '' >> $HOME/.profile
RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> $HOME/.profile
RUN echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> $HOME/.profile
RUN echo 'eval "$(pyenv init -)"' >> $HOME/.profile
RUN echo 'eval "$(pyenv virtualenv-init -)"' >> $HOME/.profile

# Install Jabba aka Java Version Manager
RUN curl -sL https://github.com/shyiko/jabba/raw/master/install.sh | bash && . ~/.jabba/jabba.sh

# Copy entrypoint into container
COPY ./entrypoint.sh /entrypoint.sh
# Copy main into container
COPY ./main.sh /main.sh

# Add color to shell
RUN echo "PS1='\[\033[1;36m\]\u\[\033[1;31m\]@\[\033[1;32m\]\h:\[\033[1;35m\]\w\[\033[1;31m\]\$\[\033[0m\] '" >> $HOME/.profile

# Copy .profile to .bashrc .bash_profile .bash_login
RUN cp $HOME/.profile $HOME/.bashrc 
RUN cp $HOME/.profile $HOME/.bash_profile 
RUN cp $HOME/.profile $HOME/.bash_login

# Run script
ENTRYPOINT ["ash", "-l", "/entrypoint.sh"]