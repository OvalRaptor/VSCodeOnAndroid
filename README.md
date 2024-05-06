# Visual Studio Code On Android

![1000123297](https://github.com/OvalRaptor/VSCodeOnAndroid/assets/114360124/02502d8f-0c59-4940-9bca-c0ebf4506b64)




This repository makes it simple to run Visual Studio Code on your android device. Code server and a web application have been used to make a more native like experience. This removes most of the extension limitations vscode.dev creates on mobile, gives you the ability to use vscode offline and also allows you to open local folders from your device.

# What is code server?

Code Server is a tool that allows you to run Visual Studio Code (VS Code) on a remote server and access it through a web browser. It’s designed to provide the full VS Code experience, including support for extensions and direct terminal access, on any machine with a web browser, even those that cannot install VS Code natively, like tablets or Chromebooks.

While Code Server supports most VS Code extensions, some may not work properly due to the remote environment. The big limitation is the inability of remote development using SSH and tunnels. 

# Requirements:

1. An Android device
2. A Minimum of 5GB free storage
3. Termux application
4. Visual Studio Code Application

# Support

### Programming Languages:

C/C++: With build-essential and gdb for building and debugging.

Python: Both python (Python 3.x) and python2 (Python 2.x) are included.

Node.js: For JavaScript and server-side development.

Java: openjdk-17 for Java applications.

PHP: For server-side scripting.

Ruby: Along with bundler for managing Ruby gems.

Go (Golang): For Go language development.

Rust: For Rust language development.

### Databases:

MariaDB: A community-developed fork of MySQL.

PostgreSQL: An advanced open-source relational database.

MongoDB: A NoSQL database for working with large-scale document data.

### Other Tools:

Yarn: A package manager for Node.js projects.

Ripgrep: A search tool used by VSCode.

Git: For version control and collaboration.


# How to install:

1. Install the latest termux application from the GitHub repository and allow Termux notifications.

   https://github.com/termux/termux-app

2. Install The Vscode.apk from the release tab.

   https://github.com/OvalRaptor/VSCodeOnAndroid/releases
   
3. Once both Apks are installed copy the script below to begin the installation. Make sure you allow termux storage permissions when it prompts you.
```
apt update && apt upgrade -o Dpkg::Options::="--force-confnew" -y && termux-setup-storage && sleep 5 && apt update && apt install git -y && git clone https://github.com/OvalRaptor/VSCodeOnAndroid.git && cd VSCodeOnAndroid && chmod +x install.sh && ./install.sh

```

Once the installation is complete exit termux by typing "exit" and press enter. Re-open termux and type 'vs' to start the code server. The server can run in the background of your phone, however if you want to stop the server, open the termux terminal and type 'stop'.

# Extensions

Some extensions may not be avaliable to install through code server such as live server. To get around this use open vsx to download the .vsix extensions.

https://open-vsx.org/

You can then install these extensions by following the video below:

![1000123311](https://github.com/OvalRaptor/VSCodeOnAndroid/assets/114360124/47428b29-8aab-461b-9f65-49ab6dc65d7f)



That's it, have fun! :)

# Credits

Custom Bashrc - https://github.com/knightfall-cs/termux-bashrc (KnightFall)

Code server - https://github.com/coder/code-server (Coder)
