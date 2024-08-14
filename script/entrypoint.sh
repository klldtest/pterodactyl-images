#!/bin/bash
cd /home/container

# Register SERVER_PORT to PORT in environment
export PORT=$SERVER_PORT

# Remove previous bash profile
rm -rf $HOME/.profile $HOME/.bashrc $HOME/.bash_profile $HOME/.bash_login

# Allow file executable without using ./
if [ "$PNPM_HOME" != '' ]; then
    export PATH="$PNPM_HOME:$PATH"
fi
export PATH="$PATH:."

# Add color to shell
export PS1='\[\033[1;36m\]\u\[\033[1;31m\]@\[\033[1;32m\]\h:\[\033[1;35m\]\w\[\033[1;31m\]\$\[\033[0m\] '

# Replace Startup Variables
#MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo "${USER}@$(hostname):${HOME}$ ${STARTUP}"

# Run the Server
${STARTUP}
