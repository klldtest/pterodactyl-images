#!/bin/ash

# Run package installation
if [[ "$AUTO_INSTALL_PACKAGE" == "TRUE"  ]]; then
    echo " "
    echo "*************************************************************"
    echo "* Installing dependencies..."
    echo "*************************************************************"
    if [ -f "./Pipfile" ]; then
        # Install or upgrading pipenv
        echo " "
        echo "*************************************************************"
        echo "* Updating PATH"
        echo "*************************************************************"
        export PATH="/home/container/.local/bin:"$PATH
        echo " "
        echo "*************************************************************"
        echo "* Upgading pipenv"
        echo "*************************************************************"
        pip install --user --upgrade pipenv
        echo "*************************************************************"
        echo " "
        echo "*************************************************************"
        echo "* Changing pipenv python path"
        echo "*************************************************************"
        pipenv --python /usr/local/bin/python
        pipenv install
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