#!/bin/bash
cd /home/container

# Output Current Node | NPM Version
echo "Node: "
node -v
echo "NPM: "
npm -v

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Run the Server
${MODIFIED_STARTUP}
