#!/bin/ash
cd /home/container

# Install app version manager
ash -l /install.sh

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo "@$(hostname):${HOME}$ ${MODIFIED_STARTUP}"

# Run the Server
ash -l ${MODIFIED_STARTUP}