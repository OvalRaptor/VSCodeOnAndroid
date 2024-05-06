#!/bin/bash

# Function to handle errors
error_handler() {
    echo -e "\033[31mAn error occurred. Please check the output above for details.\033[0m"
    exit 1
}

# Trap any errors
trap 'error_handler' ERR

# Welcome message
echo -e "\033[32mWelcome to VSCode on Android\033[0m"

# Install tur-repo and update package lists
echo -e "\033[32mSetting up tur-repo and updating package lists...\033[0m"
apt-get update -y && apt-get install -y tur-repo

# Ensure tur-repo is ready before continuing
if [ "$(apt list --upgradable | grep tur-repo)" ]; then
    echo -e "\033[31mtur-repo is not ready. Please try running the script again later.\033[0m"
    exit 1
fi

# Proceed with the rest of the installations
echo -e "\033[32mInstalling code server and dependencies on Termux...\033[0m"
apt-get update -y && apt-get upgrade -y
apt-get install -y build-essential gdb python python2 nodejs openjdk-17 php ruby golang rust yarn ripgrep mariadb postgresql mongodb code-server
gem install bundler

# Configure Databases
echo -e "\033[32mConfiguring databases...\033[0m"
mysql_install_db
initdb ~/../usr/var/lib/postgresql

# Install .bashrc
echo -e "\033[32mInstalling .bashrc configuration...\033[0m"
bashrc_path="/data/data/com.termux/files/usr/etc/bash.bashrc"
backup_path="$HOME/VSCodeOnAndroid/backup"

# Create backup directory if it doesn't exist
mkdir -p "$backup_path"

# Backup the current .bashrc file
cp -v "$bashrc_path" "$backup_path"

# Replace the .bashrc file with the new one
cp -v "bash.bashrc" "$bashrc_path"

echo -e "\033[32mInstallation script complete. Please restart Termux.\033[0m"
