#!/bin/ash

echo " "
echo "*************************************************************"
echo "* Checking required command packages"
echo "*************************************************************"

if ! command -v nvm &> /dev/null & ! command -v pyenv &> /dev/null & ! command -v jabba &> /dev/null
then
    echo "* Required command not found! Installing..."
    rm -rf $HOME/.profile $HOME/.bashrc $HOME/.bash_profile $HOME/.bash_login
    # Create .profile
    echo '' > $HOME/.profile
    # Add color to shell
    echo "PS1='\[\033[1;36m\]\u\[\033[1;31m\]@\[\033[1;32m\]\h:\[\033[1;35m\]\w\[\033[1;31m\]\$\[\033[0m\] '" >> $HOME/.profile
    echo "*************************************************************"
fi

# Check for nvm
if ! command -v nvm &> /dev/null
then
    echo "* Installing nvm..."
    echo "*************************************************************"
    # Deleting nvm folder
    rm -rf $HOME/.nvm
    # Install Node Version Manager
    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | ash
    echo "*************************************************************"
    echo "* nvm installed!"
    echo "*************************************************************"
fi

# Check for pyenv
if ! command -v pyenv &> /dev/null
then
    echo "* Installing pyenv..."
    echo "*************************************************************"
    # Deleting pyenv folder
    rm -rf $HOME/.pyenv
    # Install Python Version Manager
    curl https://pyenv.run | ash
    # Load into .profile
    echo '' >> $HOME/.profile
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> $HOME/.profile
    echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> $HOME/.profile
    echo 'eval "$(pyenv init -)"' >> $HOME/.profile
    echo 'eval "$(pyenv virtualenv-init -)"' >> $HOME/.profile
    echo "*************************************************************"
    echo "* pyenv installed!"
    echo "*************************************************************"
fi

# Check for jabba
if ! command -v jabba &> /dev/null
then
    echo "* Installing jabba..."
    echo "*************************************************************"
    # Deleting jabba folder
    rm -rf $HOME/.jabba
    # Install Jabba aka Java Version Manager
    curl -sL https://github.com/shyiko/jabba/raw/master/install.sh | bash && . ~/.jabba/jabba.sh
    echo "*************************************************************"
    echo "* jabba installed!"
    echo "*************************************************************"
fi

# Copy .profile to .bashrc .bash_profile .bash_login
cp $HOME/.profile $HOME/.bashrc
cp $HOME/.profile $HOME/.bash_profile
cp $HOME/.profile $HOME/.bash_login

echo "* All required command packages has installed"
echo "*************************************************************"
echo " "