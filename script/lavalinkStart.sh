#!/bin/bash

# Empty line
echo " "

# Output Current Script | Python Version | Pip Version | PHP Version
echo "*************************************************************"
echo "* Script: "$(script -V)
echo "* Python: "$(python3 --version)
echo "* Pip: "$(pip3 --version)
echo "* Java: "$(java -version)
echo "*************************************************************"

# Empty line
echo " "

# Change {{SERVER MEMORY}} to SERVER MEMORY
LAVALINK_STARTUP_SCRIPT=${LAVALINK_STARTUP_SCRIPT//"{{SERVER_MEMORY}}"/"$SERVER_MEMORY"}

# Output Current Settings
echo "*************************************************************"
echo "* Lavalink Version: $LAVALINK_VERSION"
echo "* Lavalink Password: $LAVALINK_PASSWORD (Please hide this in your screenshot)"
echo "* Automatic Update: $LAVALINK_UPDATE"
echo "* Shell Access: $SHELL_ACCESS"
echo "* Lavalink Startup Script: $LAVALINK_STARTUP_SCRIPT"
echo "*************************************************************"

# Register SERVER_PORT to PORT in environment
export PORT=$SERVER_PORT

# Check lavalink exist
if [ -f "./Lavalink.jar" ]; then
    # Automatic update
    if [[ "$LAVALINK_UPDATE" == "TRUE"  ]]; then
        if [[ "$LAVALINK_VERSION" == "ORIGINAL"  ]]; then
            # Empty line
            echo " "
            echo "*************************************************************"
            echo "* Downloading original version of Lavalink"
            echo "*************************************************************"
            curl -L "https://github.com/freyacodes/Lavalink/releases/latest/download/Lavalink.jar" -o Lavalink.jar
        elif [[ "$LAVALINK_VERSION" == "MODIFIED" ]]; then
            # Empty line
            echo " "
            echo "*************************************************************"
            echo "* Downloading modified version of Lavalink"
            echo "*************************************************************"
            curl -L "https://github.com/davidffa/lavalink/releases/latest/download/Lavalink.jar" -o Lavalink.jar
        fi
    fi
else
    if [[ "$LAVALINK_VERSION" == "ORIGINAL"  ]]; then
        # Empty line
        echo " "
        echo "*************************************************************"
        echo "* Downloading original version of Lavalink"
        echo "*************************************************************"
        curl -L "https://github.com/freyacodes/Lavalink/releases/latest/download/Lavalink.jar" -o Lavalink.jar
    elif [[ "$LAVALINK_VERSION" == "MODIFIED" ]]; then
        # Empty line
        echo " "
        echo "*************************************************************"
        echo "* Downloading modified version of Lavalink"
        echo "*************************************************************"
        curl -L "https://github.com/davidffa/lavalink/releases/latest/download/Lavalink.jar" -o Lavalink.jar
    fi
fi

if [ -f "./application.yml.original" ]; then
    if [[ "$LAVALINK_VERSION" == "ORIGINAL"  ]]; then
        # Empty line
        echo " "
        echo "*************************************************************"
        echo "* Changing application config to original"
        echo "*************************************************************"
        mv ./application.yml ./application.yml.modified
        mv ./application.yml.original ./application.yml
    fi
elif [ -f "./application.yml.modified" ]; then
    if [[ "$LAVALINK_VERSION" == "MODIFIED" ]]; then
        # Empty line
        echo " "
        echo "*************************************************************"
        echo "* Changing application config to modified"
        echo "*************************************************************"
        mv ./application.yml ./application.yml.original
        mv ./application.yml.modified ./application.yml
    fi
else
    # Empty line
    echo " "
    echo "*************************************************************"
    echo "* Downloading original and modified version of config files"
    echo "*************************************************************"
    curl -L https://raw.githubusercontent.com/davidffa/lavalink/dev/application.yml.example -o ./application.yml.original
    curl -L https://raw.githubusercontent.com/freyacodes/Lavalink/master/LavalinkServer/application.yml.example -o ./application.yml.modified

    if [[ "$LAVALINK_VERSION" == "ORIGINAL"  ]]; then
        # Empty line
        echo " "
        echo "*************************************************************"
        echo "* Changing application config to original"
        echo "*************************************************************"
        mv ./application.yml ./application.yml.modified
        mv ./application.yml.original ./application.yml
    elif [[ "$LAVALINK_VERSION" == "MODIFIED" ]]; then
        # Empty line
        echo " "
        echo "*************************************************************"
        echo "* Changing application config to modified"
        echo "*************************************************************"
        mv ./application.yml ./application.yml.original
        mv ./application.yml.modified ./application.yml
    fi
fi

# Change password
# Empty line
echo " "
echo "*************************************************************"
echo "* Changing password to "$LAVALINK_PASSWORD
echo "*************************************************************"
sed -r "s/^(\s*password\s*:\s*).*/\1${LAVALINK_PASSWORD}/" -i ./application.yml

# Change port
# Empty line
echo " "
echo "*************************************************************"
echo "* Changing port to "$PORT
echo "*************************************************************"
sed -r "s/^(\s*port\s*:\s*).*/\1${PORT}/" -i ./application.yml

# Run Shell
if [[ "$SHELL_ACCESS" == "TRUE"  ]]; then
    bash /shell.sh
else
    # Empty line
    echo " "
    echo "*************************************************************"
    echo "* Skipping shell access..."
    echo "* Change the setting \"SHELL ACCESS\" in Startup tab"
    echo "*************************************************************"
fi

# Empty line
echo " "
echo "*************************************************************"
echo "* Starting application..."
echo "*************************************************************"
# Run App
$LAVALINK_STARTUP_SCRIPT