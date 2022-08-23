#!/bin/bash

# Output Current Script | Node | NPM Version
echo "*************************************************************"
echo "Script: "$(script -V)
echo "Node: "$(node -v)
echo "NPM: "$(npm -v)
echo "*************************************************************"

# Output Current Settings
echo "*************************************************************"
echo "Github Username: "$GITHUB_USERNAME
echo "Github Token: "$GITHUB_TOKEN 
echo "Repository URL: "$GITHUB_REPO 
echo "Repository Branch: "$GITHUB_BRANCH
echo "Github Auto Pull: "$GIT_AUTO_PULL 
echo "Shell Access: "$SHELL_ACCESS 
echo "Package Manager: "$PACKAGE_MANAGER
echo "Auto Install Package: "$AUTO_INSTALL_PACKAGE 
echo "Node Startup Script #1: "$NODE_STARTUP_SCRIPT_1 
echo "Node Startup Script #2: "$NODE_STARTUP_SCRIPT_2
echo "*************************************************************"

# Fetch repository
if [[ "$GIT_AUTO_PULL" == "true" ]]; then
    if [[ "$GITHUB_USERNAME" == "" ]]; then
        echo "*************************************************************"
        echo "Missing Github Username: "$GITHUB_USERNAME
        echo "*************************************************************"
        exit 1
    if
    if [[ "$GITHUB_TOKEN" == "" ]]; then
        echo "*************************************************************"
        echo "Missing Github Token: "$GITHUB_TOKEN
        echo "*************************************************************"
        exit 1
    fi
    if [[ "$GITHUB_REPO" == "" ]]; then
        echo "*************************************************************"
        echo "Missing Github Repo: "$GITHUB_REPO
        echo "*************************************************************"
        exit 1
    fi
    if [[ "$GITHUB_BRANCH" == "" ]]; then
        echo "*************************************************************"
        echo "Missing Github Branch: "$GITHUB_BRANCH
        echo "*************************************************************"
        exit 1
    fi

    echo "*************************************************************"
    echo "Saving github credentials into global configuration..."
    echo "*************************************************************"
    git config --global user.name "$GITHUB_USERNAME"
    git config --global user.password "$GITHUB_TOKEN"

    if [[ -d "/home/container/.git" ]]; then
        echo "*************************************************************"
        echo "Found .git folder. Pulling from existing repository..."
        echo "*************************************************************"
        git pull
    else 
        echo "*************************************************************"
        echo "Pulling repository..."
        echo "*************************************************************"
        if [[ $GITHUB_REPO = *.git ]]; then
            git clone $GITHUB_REPO
        else
            git clone "$GITHUB_REPO.git"
        fi
    fi
fi

# Run Shell
if [[ "$SHELL_ACCESS" == "true"  ]]; then
    bash /shell.sh
fi

# Run package installation
if [[ "$AUTO_INSTALL_PACKAGE" == "true"  ]]; then
    if [[ "$PACKAGE_MANAGER" == "npm" ]]; then
        echo "NPM"
        npm install
    elif [[ "$PACKAGE_MANAGER" == "yarn" ]]; then
        echo "YARN"
        yarn install
    elif [[ "$PACKAGE_MANAGER" == "pnpm" ]]; then
        echo "PNPM"
        pnpm install
    else
        echo "Invalid package manager"
        exit 1
    fi
fi

# Run App
$NODE_STARTUP_SCRIPT_1
$NODE_STARTUP_SCRIPT_2