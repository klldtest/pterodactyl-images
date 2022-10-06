#!/bin/ash

# Print current version manager list and environment variable
echo " "
echo "*************************************************************"
echo "* App Version Manager"
echo "*************************************************************"
echo "* nvm: $(nvm -v)"
echo "* pyenv: $(pyenv -v)"
echo "* jabba: $(jabba --version)"
echo "*************************************************************"
echo " "
echo "*************************************************************"
echo "* Github Variable"
echo "*************************************************************"
echo "* Github Username: $GITHUB_USERNAME"
echo "* Github Token: $GITHUB_TOKEN (Hide in your screenshot)"
echo "* Repository URL: $GITHUB_REPO"
echo "* Repository Branch: $GITHUB_BRANCH"
echo "* Github Auto Pull: $GITHUB_AUTO_PULL"
echo "*************************************************************"
echo " "
echo "*************************************************************"
echo "* Optional Variable"
echo "*************************************************************"
echo "* Shell Access: $SHELL_ACCESS"
echo "*************************************************************"
echo " "
echo "*************************************************************"
echo "* Version Variable"
echo "*************************************************************"
echo "* NodeJS Version: $NODEJS_VERSION"
echo "* Python Version: $PYTHON_VERSION"
echo "* Java Version: $JAVA_VERSION"
echo "*************************************************************"
echo " "
echo "*************************************************************"
echo "* Startup Variable"
echo "*************************************************************"
echo "* Startup Script #1: $STARTUP_SCRIPT_1"
echo "* Startup Script #2: $STARTUP_SCRIPT_2"
echo "*************************************************************"
echo " "
echo "*************************************************************"
echo "* Server Information"
echo "*************************************************************"
echo "* Server IP: $SERVER_IP"
echo "* Server Port: $SERVER_PORT"
echo "* Server Memory: $SERVER_MEMORY"
echo "* Server UUID: $P_SERVER_UUID"
echo "* Server Location: $P_SERVER_LOCATION"
echo "*************************************************************"
echo " "
echo "*************************************************************"
echo "WARNING! DO NOT DELETE THIS FOLDER AND FILES"
echo ".nvm .jabba .pyenv .profile .bashrc .bash_profile .bash_login"
echo "*************************************************************"

export PORT=$SERVER_PORT

ash -l /script/node.sh
ash -l /script/python.sh
ash -l /script/java.sh
ash -l /script/github.sh
ash -l /script/shell.sh
ash -l /script/note.sh
ash -l /script/start.sh