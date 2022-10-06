#!/bin/ash

cd /home/container
export PYTHON_BUILD_CACHE_PATH=/home/container/.pyenv/tmp
mkdir /home/container/.pyenv/tmp

echo " "
echo "*************************************************************"
echo "* Installing Python"
echo "*************************************************************"

if [ "$PYTHON_VERSION" == "" ] || [ "$PYTHON_VERSION" ==  "latest" ] ||  [ "$PYTHON_VERSION" == "lts" ]; then
    #pyenv install 3.10.4
    #pyenv global 3.10.4
else
    pyenv install $PYTHON_VERSION
    pyenv global $ PYTHON_VERSION
fi