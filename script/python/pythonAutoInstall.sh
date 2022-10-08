#!/bin/ash

# Run package installation
if [[ "$AUTO_INSTALL_PACKAGE" == "TRUE"  ]]; then
    echo " "
    echo "*************************************************************"
    echo "* Installing dependencies..."
    echo "*************************************************************"
    if [ -f "./Pipfile" ]; then
        pipenv install
        pipenv shell
    elif [ -f "./requirements.txt" ]; then
        pip install -r ./requirements.txt
    else
        echo "* requirements.txt and Pipfile not found. Skipping..."
    fi
    echo "*************************************************************"
else
    # Empty line
    echo " "
    echo "*************************************************************"
    echo "* Skipping automatic dependencies install..."
    echo "* Change the setting \"AUTO INSTALL PACKAGE\" in Startup tab"
    echo "*************************************************************"
fi