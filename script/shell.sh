#!/bin/bash

# Empty line
echo " "
echo "*************************************************************"
echo "* You have entered shell access mode."
echo "* To exit please enter exit."
echo "* If you stuck inside a program, please restart the container."
echo "*************************************************************"

scriptVer=$(script -V)

if [[ "$scriptVer" == "script from util-linux 2.32.1" ]]; then
    script -q
elif [[ "$scriptVer" == "script from util-linux 2.38" ]]; then
    script -I /dev/null -O /dev/null -B /dev/null -q
else
    script -I /dev/null -O /dev/null -B /dev/null -q
fi


# Empty line
echo " "
echo "*************************************************************"
echo "* You have exited shell access mode."
echo "*************************************************************"