#!/bin/bash

cd /home/container

echo " "
echo "*************************************************************"
echo "* GITHUB"
echo "*************************************************************"

# Fetch repository
if [[ "$GIT_AUTO_PULL" == "TRUE" ]]; then
    if [[ "$GITHUB_REPO" == "" ]]; then
        echo " "
        echo "*************************************************************"
        echo "* Missing Github Repo"
        echo "*************************************************************"
        exit 1
    fi
    if [[ "$GITHUB_BRANCH" == "" ]]; then
        echo " "
        echo "*************************************************************"
        echo "* Missing Github Branch"
        echo "*************************************************************"
        exit 1
    fi

    if [[ -d "/home/container/.git" ]]; then
        echo " "
        echo "*************************************************************"
        echo "* Found .git folder. Pulling from existing repository..."
        echo "* Any changes made directly to this folder and subfolder will be lost!"
        echo "*************************************************************"

        GITHUB_REPO=${GITHUB_REPO#*//}
        if [[ $GITHUB_REPO = *.git ]]; then
            if [ "$GITHUB_USERNAME" == "" ] && [ "$GITHUB_TOKEN" == "" ]; then
                git remote set-url origin "https://$GITHUB_REPO"
            else 
                git remote set-url origin "https://$GITHUB_USERNAME:$GITHUB_TOKEN@$GITHUB_REPO"
            fi
        else
            if [ "$GITHUB_USERNAME" == "" ] && [ "$GITHUB_TOKEN" == "" ]; then
                git remote set-url origin "https://$GITHUB_REPO.git"
            else 
                git remote set-url origin "https://$GITHUB_USERNAME:$GITHUB_TOKEN@$GITHUB_REPO.git"
            fi
            
        fi

        git fetch --all
        git reset --hard origin/$GITHUB_BRANCH
    else 
        echo " "
        echo "*************************************************************"
        echo "* Pulling repository..."
        echo "* Any changes made directly to this folder and subfolder will be lost!"
        echo "*************************************************************"

        GITHUB_REPO=${GITHUB_REPO#*//}
        if [[ $GITHUB_REPO = *.git ]]; then
            if [ "$GITHUB_USERNAME" == "" ] && [ "$GITHUB_TOKEN" == "" ]; then
                git clone --branch $GITHUB_BRANCH --progress "https://$GITHUB_REPO" temp
            else 
                git clone --branch $GITHUB_BRANCH --progress "https://$GITHUB_USERNAME:$GITHUB_TOKEN@$GITHUB_REPO" temp
            fi
        else
            if [ "$GITHUB_USERNAME" == "" ] && [ "$GITHUB_TOKEN" == "" ]; then
                git clone --branch $GITHUB_BRANCH --progress "https://$GITHUB_REPO.git" temp
            else 
                git clone --branch $GITHUB_BRANCH --progress "https://$GITHUB_USERNAME:$GITHUB_TOKEN@$GITHUB_REPO.git" temp
            fi
        fi

        for x in temp/* temp/.[!.]* temp/..?*; do
            if [ -e "$x" ]; then mv -- "$x" ./; fi
        done
    fi
else
    echo " "
    echo "*************************************************************"
    echo "* Skipping automatic repository update..."
    echo "* Change the setting \"AUTO PULL REPOSITORY\" in Startup tab"
    echo "*************************************************************"
fi