#Welcome to VSCode on Android

#Install Code Server
echo -e "\033[32m Installing code server on Termux \033[0m"
apt-get -y update
apt-get -y install nodejs-lts
apt-get -y install tur-repo 
apt-get -y install code-server

#Install Bashrc
cd /data/data/com.termux/files/usr/etc && cp -v bash.bashrc $HOME/VSCodeOnAndroid/backup/ && cd -
cp bash.bashrc /data/data/com.termux/files/usr/etc && echo -e "\033[32m Successfully installed. Restart Termux and type 'vs' to start code server. \033[0m"
