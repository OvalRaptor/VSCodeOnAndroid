#!/bin/bash

# Function to handle errors
error_handler() {
    echo -e "\033[31mAn error occurred. Please check the output above for details.\033[0m"
    exit 1
}

# Trap any errors
trap 'error_handler' ERR

# Welcome message in blue
echo -e "\033[34mWelcome to VSCode on Android\033[0m"

# Install tur-repo and update package lists in blue
echo -e "\033[34mSetting up tur-repo and updating package lists...\033[0m"
apt-get update -y && apt-get install -y tur-repo

# Ensure tur-repo is ready before continuing, in blue
if [ "$(apt list --upgradable | grep tur-repo)" ]; then
    echo -e "\033[34mtur-repo is not ready. Please try running the script again later.\033[0m"
    exit 1
fi

# Proceed with the rest of the installations in blue
echo -e "\033[34mInstalling code server and dependencies on Termux...\033[0m"
apt-get update -y && apt-get upgrade -y
apt-get install -y build-essential gdb python python2 nodejs openjdk-17 php ruby golang rust yarn ripgrep mariadb postgresql mongodb binutils pkg-config code-server
gem install bundler

# Configure Databases in blue
echo -e "\033[34mConfiguring databases...\033[0m"
mysql_install_db
initdb ~/../usr/var/lib/postgresql

# Add Keyboard Shortcuts to Code Server
echo -e "\033[34mAdding Keyboard Shortcuts...\033[0m"
mkdir -p ~/.local/share/code-server/User
echo '{
  "keyboard.dispatch": "keyCode"
}' > ~/.local/share/code-server/User/settings.json


# Install .bashrc in blue
echo -e "\033[34mInstalling .bashrc configuration...\033[0m"
bashrc_path="/data/data/com.termux/files/usr/etc/bash.bashrc"
backup_path="$HOME/VSCodeOnAndroid/backup"

# Create backup directory if it doesn't exist
mkdir -p "$backup_path"

# Backup the current .bashrc file
cp -v "$bashrc_path" "$backup_path"

# Replace the .bashrc file with the new one
cp -v "bash.bashrc" "$bashrc_path"

# Installation script complete message in blue
echo -e "\033[34mInstallation script complete. Please restart Termux.\033[0m"
