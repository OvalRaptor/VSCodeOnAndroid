#!/bin/bash

# Function to handle errors
error_handler() {
    echo -e "\033[31mAn error occurred. Please check the output above for details.\033[0m"
    exit 1
}

# Trap any errors
trap 'error_handler' ERR

# Define function to append database startup scripts to bash.bashrc
append_to_bashrc() {
    # Use 'cat' with a heredoc to append multiline text
    cat >> "/data/data/com.termux/files/usr/etc/bash.bashrc" << EOF
$1
EOF
}

# Function to install C# related packages
install_csharp() {
    # Check for arm64 architecture
    ARCH=$(uname -m)
    if [ "$ARCH" = "aarch64" ]; then
        echo -e "\033[34mDetected **arm64 architecture**, proceeding with .NET SDK installation...\033[0m"
    else
        echo -e "\033[31m.NET SDK requires an **arm64 device**. Your device does not support this architecture.\033[0m"
        exit 1
    fi

    echo -e "\033[34mInstalling C# development tools...\033[0m"
    # Download the .NET SDK installation script
    wget https://dotnet.microsoft.com/download/dotnet/scripts/v1/dotnet-install.sh

    # Make sure the script is executable
    chmod +x dotnet-install.sh

    # Install .NET SDK for arm64
    ./dotnet-install.sh --version 6.0.100 --architecture arm64 --install-dir "$HOME/.dotnet"

    # Add .NET SDK to PATH for all future sessions
    echo 'export PATH=$HOME/.dotnet:$PATH' >> /data/data/com.termux/files/usr/etc/bash.bashrc
    echo 'export DOTNET_GCHeapHardLimit=700000000' >> /data/data/com.termux/files/usr/etc/bash.bashrc

    # Source the bash.bashrc to update PATH for the current session
    source /data/data/com.termux/files/usr/etc/bash.bashrc

    # Verify .NET installation
    if [ -f "$HOME/.dotnet/dotnet" ]; then
        $HOME/.dotnet/dotnet --version
    else
        echo -e "\033[31mThe .NET executable was not found. Please check the installation.\033[0m"
    fi
}

# Function to install Python related packages
install_python() {
    echo -e "\033[34mInstalling Python development tools...\033[0m"
    apt-get install -y python python2
}

# Function to install JavaScript related packages
install_javascript() {
    echo -e "\033[34mInstalling JavaScript development tools...\033[0m"
    apt-get install -y nodejs yarn
}

# Function to install Java related packages
install_java() {
    echo -e "\033[34mInstalling Java development tools...\033[0m"
    apt-get install -y openjdk-17
}

# Function to install PHP related packages
install_php() {
    echo -e "\033[34mInstalling PHP development tools...\033[0m"
    apt-get install -y php
}

# Function to install Ruby related packages
install_ruby() {
    echo -e "\033[34mInstalling Ruby development tools...\033[0m"
    apt-get install -y ruby
    gem install bundler
}

# Function to install Go related packages
install_go() {
    echo -e "\033[34mInstalling Go development tools...\033[0m"
    apt-get install -y golang
}

# Function to install Rust related packages
install_rust() {
    echo -e "\033[34mInstalling Rust development tools...\033[0m"
    apt-get install -y rust
}

# Function to install MariaDB and append startup script to bash.bashrc
install_mariadb() {
    echo -e "\033[34mInstalling MariaDB...\033[0m"
    apt-get install -y mariadb
    mysql_install_db
    append_to_bashrc "# Start MariaDB
if ! pgrep -x \"mysqld\" > /dev/null; then
    mysqld_safe -u root &
fi"
}

# Function to install PostgreSQL and append startup script to bash.bashrc
install_postgresql() {
    echo -e "\033[34mInstalling PostgreSQL...\033[0m"
    apt-get install -y postgresql
    initdb ~/../usr/var/lib/postgresql

    # Start PostgreSQL service
    pg_ctl -D ~/../usr/var/lib/postgresql start &

    # Wait for PostgreSQL to start
    sleep 5

    # Create 'postgres' user without a password
    psql -c "CREATE ROLE postgres LOGIN CREATEDB CREATEROLE SUPERUSER;"

    append_to_bashrc "# Start PostgreSQL
if ! pgrep -x \"postgres\" > /dev/null; then
    pg_ctl -D ~/../usr/var/lib/postgresql start &
fi"
}

# Function to install MongoDB and append startup script to bash.bashrc
install_mongodb() {
    echo -e "\033[34mInstalling MongoDB...\033[0m"
    apt-get install -y mongodb
    append_to_bashrc "# Start MongoDB
if ! pgrep -x \"mongod\" > /dev/null; then
    mongod --dbpath /data/data/com.termux/files/usr/var/lib/mongodb > /data/data/com.termux/files/usr/var/lib/mongodb/mongod.log 2>&1 &
fi"
}

# Function to display the installation menu
show_installation_menu() {
    while true; do
        echo -e "\033[34mSelect an option to install:\033[0m"
        echo "1) C#"
        echo "2) Python"
        echo "3) JavaScript"
        echo "4) Java"
        echo "5) PHP"
        echo "6) Ruby"
        echo "7) Go"
        echo "8) Rust"
        echo "9) MariaDB"
        echo "10) PostgreSQL"
        echo "11) MongoDB"
        echo "12) Exit"
        read -p "Enter option: " option

        case $option in
            1) install_csharp ;;
            2) install_python ;;
            3) install_javascript ;;
            4) install_java ;;
            5) install_php ;;
            6) install_ruby ;;
            7) install_go ;;
            8) install_rust ;;
            9) install_mariadb ;;
            10) install_postgresql ;;
            11) install_mongodb ;;
            12) echo "Exiting installation menu."; break ;;
            *) echo -e "\033[31mInvalid option: $option\033[0m" ;;
        esac
    done
}

if [ "$1" == "menu" ]; then
    show_installation_menu
    exit 0
fi

# Welcome message in blue
echo -e "\033[34mWelcome to the interactive VSCode on Android installation.\033[0m"

# Install tur-repo and update package lists in blue
echo -e "\033[34mSetting up tur-repo and updating package lists...\033[0m"
apt-get update -y && apt-get upgrade -y && apt-get install -y tur-repo

# Ensure tur-repo is ready before continuing, in blue
if [ "$(apt list --upgradable | grep tur-repo)" ]; then
    echo -e "\033[34mtur-repo is not ready. Please try running the script again later.\033[0m"
    exit 1
fi

# Proceed with the rest of the installations in blue
echo -e "\033[34mInstalling code server and dependencies on Termux...\033[0m"
apt-get install -y build-essential gdb binutils wget pkg-config code-server

prompt_for_languages() {
    echo -e "\033[34mEnter the numbers of the programming languages you want to install, separated by spaces, or enter 'None' to skip:\033[0m"
    echo "1) C#"
    echo "2) Python"
    echo "3) JavaScript"
    echo "4) Java"
    echo "5) PHP"
    echo "6) Ruby"
    echo "7) Go"
    echo "8) Rust"
    echo "9) All"
    echo "10) None"
    read -p "Enter options: " input

    # Split the input into an array of numbers
    IFS=' ' read -ra options <<< "$input"

    # Process each option
    for option in "${options[@]}"; do
        case $option in
            1) install_csharp ;;
            2) install_python ;;
            3) install_javascript ;;
            4) install_java ;;
            5) install_php ;;
            6) install_ruby ;;
            7) install_go ;;
            8) install_rust ;;
            9)
                install_csharp
                install_python
                install_javascript
                install_java
                install_php
                install_ruby
                install_go
                install_rust
                ;;
            10)
                echo -e "\033[34mNo programming languages will be installed.\033[0m"
                ;;
            *)
                echo -e "\033[31mInvalid option: $option\033[0m" ;;
        esac
    done
}

# Function to prompt the user for multiple database installations
prompt_for_databases() {
    echo -e "\033[34mEnter the numbers of the databases you want to install, separated by spaces:\033[0m"
    echo "1) MariaDB"
    echo "2) PostgreSQL"
    echo "3) MongoDB"
    echo "4) All"
    echo "5) None"
    read -p "Enter options: " input

    # Split the input into an array of numbers
    IFS=' ' read -ra options <<< "$input"

    # Process each option
    for option in "${options[@]}"; do
        if [ "$option" = "4" ]; then
            # If the user selects 'All', install all databases
            install_mariadb
            install_postgresql
            install_mongodb
            break
        elif [ "$option" = "5" ]; then
            echo -e "\033[34mNo databases will be installed.\033[0m"
            break
        else
            case $option in
                1) install_mariadb ;;
                2) install_postgresql ;;
                3) install_mongodb ;;
                *) echo -e "\033[31mInvalid option: $option\033[0m" ;;
            esac
        fi
    done
}

# Add Keyboard Shortcuts to Code Server
echo -e "\033[34mAdding Keyboard Shortcuts...\033[0m"
mkdir -p ~/.local/share/code-server/User
echo '{
  "keyboard.dispatch": "keyCode"
}' > ~/.local/share/code-server/User/settings.json


# Ensure the backup directory exists
mkdir -p "$HOME/VSCodeOnAndroid/backup"

# Check if the custom .bashrc exists before copying
if [ -f "$HOME/VSCodeOnAndroid/bash.bashrc" ]; then
    # Backup the current .bashrc file
    cp -v "/data/data/com.termux/files/usr/etc/bash.bashrc" "$HOME/VSCodeOnAndroid/backup"
    # Replace the .bashrc file with the new one
    cp -v "$HOME/VSCodeOnAndroid/bash.bashrc" "/data/data/com.termux/files/usr/etc/bash.bashrc"
else
    echo -e "\033[31mCustom .bashrc not found. Please ensure VSCodeOnAndroid is cloned correctly.\033[0m"
    exit 1
fi
# Call the function to prompt for language installations
prompt_for_languages

# Call the function to prompt for database installations
prompt_for_databases
# Installation script complete message in blue
echo -e "\033[34mInstallation script complete. Please type 'exit' and press Enter to close the Termux session.\033[0m"
