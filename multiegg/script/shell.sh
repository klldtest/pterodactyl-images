#!/bin/ash

cd /home/container

echo " "
echo "*************************************************************"
echo "* SHELL"
echo "*************************************************************"

# Run Shell
if [[ "$SHELL_ACCESS" == "TRUE"  ]]; then
    echo " "
    echo "*************************************************************"
    echo "* You have entered shell access mode."
    echo "* To exit please enter exit."
    echo "* If you stuck inside a program, please restart the container."
    echo "*************************************************************"
    echo " "
    ash -l 
    echo " "
    echo "*************************************************************"
    echo "* You have exited shell access mode."
    echo "*************************************************************"
else
    echo " "
    echo "*************************************************************"
    echo "* Skipping shell access..."
    echo "* Change the setting \"SHELL ACCESS\" in Startup tab"
    echo "*************************************************************"
fi