#!/bin/bash

# Empty line
echo " "

# Output Current Script | Python Version | Pip Version | PHP Version
echo "*************************************************************"
echo "* Script: "$(script -V)
echo "* Python: "$(python --version)
echo "* Pip: "$(pip --version)
echo "* PHP: "$(php -v)
echo "*************************************************************"

# Empty line
echo " "

# Output Current Settings
echo "*************************************************************"
echo "* Github Username: $GITHUB_USERNAME"
echo "* Github Token: $GITHUB_TOKEN (Please hide this in your screenshot)"
echo "* Repository URL: $GITHUB_REPO"
echo "* Repository Branch: $GITHUB_BRANCH"
echo "* Github Auto Pull: $GIT_AUTO_PULL"
echo "* Shell Access: $SHELL_ACCESS"
echo "* Package Manager: $PACKAGE_MANAGER"
echo "* Auto Install Package: $AUTO_INSTALL_PACKAGE"
echo "* Python Startup Script #1: $PYTHON_STARTUP_SCRIPT_1"
echo "* Python Startup Script #2: $PYTHON_STARTUP_SCRIPT_2"
echo "*************************************************************"

# Register SERVER_PORT to PORT in environment
export PORT=$SERVER_PORT

# Remove temp folder
rm -rf temp

# Fetch repository
if [[ "$GIT_AUTO_PULL" == "TRUE" ]]; then
    if [[ "$GITHUB_USERNAME" == "" ]]; then
        # Empty line
        echo " "
        echo "*************************************************************"
        echo "* Missing Github Username: $GITHUB_USERNAME"
        echo "*************************************************************"
        exit 1
    fi
    if [[ "$GITHUB_TOKEN" == "" ]]; then
        # Empty line
        echo " "
        echo "*************************************************************"
        echo "* Missing Github Token: $GITHUB_TOKEN"
        echo "*************************************************************"
        exit 1
    fi
    if [[ "$GITHUB_REPO" == "" ]]; then
        # Empty line
        echo " "
        echo "*************************************************************"
        echo "* Missing Github Repo: $GITHUB_REPO"
        echo "*************************************************************"
        exit 1
    fi
    if [[ "$GITHUB_BRANCH" == "" ]]; then
        # Empty line
        echo " "
        echo "*************************************************************"
        echo "* Missing Github Branch: $GITHUB_BRANCH"
        echo "*************************************************************"
        exit 1
    fi

    if [[ -d "/home/container/.git" ]]; then
        # Empty line
        echo " "
        echo "*************************************************************"
        echo "* Found .git folder. Pulling from existing repository..."
        echo "* Any changes made directly to this folder and subfolder will be lost!"
        echo "*************************************************************"

        GITHUB_REPO=${GITHUB_REPO#*//}
        if [[ $GITHUB_REPO = *.git ]]; then
            git remote set-url origin "https://$GITHUB_USERNAME:$GITHUB_TOKEN@$GITHUB_REPO.git"
        else
            git remote set-url origin "https://$GITHUB_USERNAME:$GITHUB_TOKEN@$GITHUB_REPO.git"
        fi

        git fetch --all
        git reset --hard origin/$GITHUB_BRANCH
    else 
        # Empty line
        echo " "
        echo "*************************************************************"
        echo "* Pulling repository..."
        echo "* Any changes made directly to this folder and subfolder will be lost!"
        echo "*************************************************************"

        GITHUB_REPO=${GITHUB_REPO#*//}
        if [[ $GITHUB_REPO = *.git ]]; then
            git clone --branch $GITHUB_BRANCH --progress "https://$GITHUB_USERNAME:$GITHUB_TOKEN@$GITHUB_REPO" temp
        else
            git clone --branch $GITHUB_BRANCH --progress "https://$GITHUB_USERNAME:$GITHUB_TOKEN@$GITHUB_REPO.git" temp
        fi

        for x in temp/* temp/.[!.]* temp/..?*; do
            if [ -e "$x" ]; then mv -- "$x" ./; fi
        done
    
    fi
else
    # Empty line
    echo " "
    echo "*************************************************************"
    echo "* Skipping automatic repository update..."
    echo "* Change the setting \"AUTO PULL REPOSITORY\" in Startup tab"
    echo "*************************************************************"
fi

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

# Run package installation
if [[ "$AUTO_INSTALL_PACKAGE" == "TRUE"  ]]; then
    # Empty line
    echo " "
    echo "*************************************************************"
    echo "* Installing dependencies..."
    echo "*************************************************************"
    if [[ "$PACKAGE_MANAGER" == "npm" ]]; then
        npm install
    elif [[ "$PACKAGE_MANAGER" == "yarn" ]]; then
        yarn install
    elif [[ "$PACKAGE_MANAGER" == "pnpm" ]]; then
        pnpm install
    else
        # Empty line
        echo " "
        echo "*************************************************************"
        echo "* Invalid package manager"
        echo "*************************************************************"
        exit 1
    fi
else
    # Empty line
    echo " "
    echo "*************************************************************"
    echo "* Skipping automatic dependencies install..."
    echo "* Change the setting \"AUTO INSTALL PACKAGE\" in Startup tab"
    echo "*************************************************************"
fi

# Empty line
echo " "
echo "*************************************************************"
echo "* Starting application..."
echo "*************************************************************"
# Run App
$PYTHON_STARTUP_SCRIPT_1

# Empty line
echo " "

$PYTHON_STARTUP_SCRIPT_2