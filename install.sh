#Welcome to VSCode on Android

#Install Code Server
echo -e "\033[32m Installing code server on Termux \033[0m"
apt-get -y update
apt-get -y install tur-repo build-essential gdb python python2 nodejs openjdk-17 php ruby golang rust yarn ripgrep mariadb postgresql
apt-get -y install mongodb code-server
gem install bundler

#Configure Databases
mysql_install_db
initdb ~/../usr/var/lib/postgresql

#Install Bashrc
cd /data/data/com.termux/files/usr/etc && cp -v bash.bashrc $HOME/VSCodeOnAndroid/backup/ && cd -
cp bash.bashrc /data/data/com.termux/files/usr/etc && echo -e "\033[32m Installation Script Complete. \033[0m"
