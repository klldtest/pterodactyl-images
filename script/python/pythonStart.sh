#!/bin/bash

# Remove temp folder
rm -rf temp

# Print current version manager list and environment variable
vType='python'
cd / && ./ver.sh
cd / && ./var.sh
cd / && ./info.sh

cd / && ./github.sh
cd / && ./shell.sh
cd / && ./pythonAutoInstall.sh

# cd into container
cd /home/container

# Run App
echo " "
echo "*************************************************************"
echo "* Starting application..."
echo "*************************************************************"
if [ -f "./Pipfile" ]; then
    script="echo \"${USER}@$(hostname):${HOME}$ ${STARTUP_SCRIPT_1}\"; $STARTUP_SCRIPT_1; echo ' '; echo \"${USER}@$(hostname):${HOME}$ ${STARTUP_SCRIPT_2}\"; $STARTUP_SCRIPT_2; exit 0"
    pipenv shell $script
else
    echo "${USER}@$(hostname):${HOME}$ ${STARTUP_SCRIPT_1}"
    $STARTUP_SCRIPT_1
    echo " "
    echo "${USER}@$(hostname):${HOME}$ ${STARTUP_SCRIPT_2}"
    $STARTUP_SCRIPT_2
fi
echo "*************************************************************"
echo "* Application stopped!"
echo "*************************************************************"