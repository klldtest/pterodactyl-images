#!/bin/ash

cd /home/container

echo " "
echo "*************************************************************"
echo "* Installing Java"
echo "*************************************************************"

if [ "$JAVA_VERSION" == "" ] ||  [ "$JAVA_VERSION" == "latest" ] ||  [ "$JAVA_VERSION" == "lts" ]; then
    jabba install adopt@1.16.0
    jabba install adopt@1.16.0
else
    jabba install $JAVA_VERSION
    jabba install $JAVA_VERSION
fi