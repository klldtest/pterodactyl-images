#!/bin/ash
cd /home/container

STARTUP="/main.sh"

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo "$(hostname):~$ ${MODIFIED_STARTUP}"

# Run the Server
ash -l ${MODIFIED_STARTUP}

