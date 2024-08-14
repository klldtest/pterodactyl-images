#!/bin/bash

# Remove temp folder
rm -rf temp

# Print current version manager list and environment variable
vType='node'
cd / && ./ver.sh
cd / && ./var.sh
cd / && ./info.sh

cd / && ./github.sh
cd / && ./shell.sh
cd / && ./nodeAutoInstall.sh

# cd into container
cd /home/container

# Run App
echo " "
echo "*************************************************************"
echo "* Starting application..."
echo "*************************************************************"
echo "${USER}@$(hostname):${HOME}$ ${STARTUP_SCRIPT_1}"
$STARTUP_SCRIPT_1
echo " "
echo "*************************************************************"
echo "${USER}@$(hostname):${HOME}$ ${STARTUP_SCRIPT_2}"
$STARTUP_SCRIPT_2
echo " "
echo "*************************************************************"
echo "* Application stopped!"
echo "*************************************************************"