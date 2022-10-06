#!/bin/ash

cd /home/container

echo " "
echo "*************************************************************"
echo "* Installing NodeJS"
echo "*************************************************************"

if [ "$NODEJS_VERSION" == "" ] ||  [ "$NODEJS_VERSION" == "latest" ] ||  [ "$NODEJS_VERSION" == "lts" ]; then
    nvm install --lts
    nvm use --lts
else
    nvm install $NODEJS_VERSION
    nvm use $NODEJS_VERSION
fi