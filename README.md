# Visual Studio Code On Android

![1000123297](https://github.com/OvalRaptor/VSCodeOnAndroid/assets/114360124/02502d8f-0c59-4940-9bca-c0ebf4506b64)




This repository makes it simple to run Visual Studio Code on your android device. I've used code server to localhost a version of vscode.dev and connect via a web application to make a more native like experience. This removes the extension limitations vscode.dev creates and also allows you to open local folders from your device, exactly how vscode.dev should have been created.

Whether you have internet access or not you will still be able to use visual studio code on your device.

# Requirements:

1. An Android device
2. Termux application
3. Visual Studio Code Application

## How to install:

1. Install the latest termux application from the GitHub repository and allow notifications.

   https://github.com/termux/termux-app

2. Update and upgrade termux packages and link your internal storage to Termux.
```
apt update; apt upgrade; termux-setup-storage
```
3. Next update again and install the git package
```
apt update && apt install git
```
4. Clone the VSCodeOnAndroid repository
```
git clone https://github.com/OvalRaptor/VSCodeOnAndroid.git
```
5. Start the installation script
```
cd VSCodeOnAndroid; chmod +x install.sh; ./install.sh
```
Once the installation is complete exit termux by typing "exit" and press enter. Re-open termux and type 'vs' to start the code server. The server can run in the background of your phone however if you want to stop the server open the termux terminal, press Ctrl + C and then type 'exit'.

6. Install vscode.apk from releases.

# Extensions

Some extensions may not be avaliable to install through code server such as live server. To get around this use open vsx to download the .vsix extensions.

https://open-vsx.org/

You can then install these extensions by following the video below:

![1000123311](https://github.com/OvalRaptor/VSCodeOnAndroid/assets/114360124/47428b29-8aab-461b-9f65-49ab6dc65d7f)



That's it, have fun! :)

# Credits

Custom Bashrc - https://github.com/knightfall-cs/termux-bashrc (KnightFall)

Code server - https://github.com/coder/code-server (Coder)
