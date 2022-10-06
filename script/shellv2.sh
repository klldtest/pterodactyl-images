#!/bin/ash

# Run Shell
if [[ "$SHELL_ACCESS" == "TRUE"  ]]; then
   # Empty line
    echo " "
    echo "*************************************************************"
    echo "* You have entered shell access mode."
    echo "* To exit please enter exit."
    echo "* If you stuck inside a program, please restart the container."
    echo "*************************************************************"

    bash -l

    # Empty line
    echo " "
    echo "*************************************************************"
    echo "* You have exited shell access mode."
    echo "*************************************************************"
else
    # Empty line
    echo " "
    echo "*************************************************************"
    echo "* Skipping shell access..."
    echo "* Change the setting \"SHELL ACCESS\" in Startup tab"
    echo "*************************************************************"
fi