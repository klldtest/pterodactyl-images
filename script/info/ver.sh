#!/bin/bash

echo " "
echo "*************************************************************"
echo "* Version"
echo "*************************************************************"
if [ "$vType" = 'node' ]; then
    echo "* Node: "$(node -v)
    echo "* NPM: "$(npm -v)
    echo "* Python: "$(python --version)
    echo "* Pip: "$(pip --version)
    echo "* FFMPEG: "$(ffmpeg -version | grep "ffmpeg version")
    echo "* PHP: "$(php -v | grep "PHP" | head -1)
elif [ "$vType" = 'python' ]; then
    echo "* Python: $(python --version)"
    echo "* Pip: $(pip --version)"
    echo "* Pipenv: $(pipenv --version)"
else
    echo "* Invalid version type was passed"
fi

echo "*************************************************************"