#Welcome to VSCode on Android

#Install Code Server
echo -e "\033[32m Installing code server on Termux \033[0m"
apt-get -y update
apt-get -y install tur-repo build-essential gdb python python2 nodejs openjdk-17 php ruby golang rust yarn ripgrep git mariadb postgresql
apt-get -y install mongodb code-server
gem install bundler

#Configure Databases
mysql_install_db
mysqld_safe -u root &
initdb ~/../usr/var/lib/postgresql
pg_ctl -D ~/../usr/var/lib/postgresql start
mongod --dbpath ~/../usr/var/lib/mongodb --logpath ~/../usr/var/log/mongodb/mongod.log --fork

#Install Bashrc
cd /data/data/com.termux/files/usr/etc && cp -v bash.bashrc $HOME/VSCodeOnAndroid/backup/ && cd -
cp bash.bashrc /data/data/com.termux/files/usr/etc && echo -e "\033[32m Successfully installed. Restart Termux and type 'vs' to start code server. \033[0m"
