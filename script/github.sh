#!/bin/bash

cd /home/container

# Include this boilerplate
function jumpto {
    label=$1
    cmd=$(sed -n "/$label:/{:a;n;p;ba};" $0 | grep -v ':$')
    eval "$cmd"
    exit
}

start=${1:-"start"}

jumpto $start

start:
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

        jumpto github
    else 
        echo " "
        echo "*************************************************************"
        echo "* Pulling repository..."
        echo "* Any changes made directly to this folder and subfolder will be lost!"
        echo "*************************************************************"
           
        jumpto github
    fi
else
    echo " "
    echo "*************************************************************"
    echo "* Skipping automatic repository update..."
    echo "* Change the setting \"AUTO PULL REPOSITORY\" in Startup tab"
    echo "*************************************************************"
    
    jumpto end
fi

github:
if [[ "$SKIP_OVERWRITE_WARNING" == "FALSE" ]]; then
    echo "Change the setting \"SKIP OVERWRITE WARNING\" in Startup tab"
    echo "Do you want to proceed? (y/n)"
    read -p "Answer: " yn
else
    echo " "
    echo "*************************************************************"
    echo "* Skipping overwrite warning"
    echo "* Change the setting \"SKIP OVERWRITE WARNING\" in Startup tab"
    echo "*************************************************************"
    yn=y
fi

github_:
case $yn in 
    [nN] ) echo "Skipping...";
        break;;
    [yY] ) 
        GITHUB_REPO=${GITHUB_REPO#*//}

        if [[ $GITHUB_REPO = *.git ]]; then
            GITHUB_REPO=$GITHUB_REPO
        else
            GITHUB_REPO=$GITHUB_REPO".git"
        fi

        if [ "$GITHUB_USERNAME" == "" ] && [ "$GITHUB_TOKEN" == "" ]; then
            GITHUB_REPO="https://$GITHUB_REPO"
        else 
            GITHUB_REPO="https://$GITHUB_USERNAME:$GITHUB_TOKEN@$GITHUB_REPO"
        fi

        if [[ $GITHUB_REPO = *.git ]]; then
           
        else
            if [ "$GITHUB_USERNAME" == "" ] && [ "$GITHUB_TOKEN" == "" ]; then
                git remote set-url origin "https://$GITHUB_REPO.git"
            else 
                git remote set-url origin "https://$GITHUB_USERNAME:$GITHUB_TOKEN@$GITHUB_REPO.git"
            fi
        fi

        if [[ -d "/home/container/.git" ]]; then
            git remote set-url origin $GITHUB_REPO
            git status
            git stash -u
            git stash drop
            git status
            git pull --progress
        else
            git clone --progress $GITHUB_REPO temp

            for x in temp/* temp/.[!.]* temp/..?*; do
                if [ -e "$x" ]; then mv -- "$x" ./; fi
            done

            git checkout $GITHUB_BRANCH
        fi
        ;;
    * ) echo "Invalid Response";;
esac

end:
echo " "