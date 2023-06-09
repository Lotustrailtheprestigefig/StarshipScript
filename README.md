# StarshipScript
Starship Script to install starship with configuration files on a linux distro.


A standard script that will transform your original terminal into a new terminal with some nice icons. 

You must be logged in as a root user. 
First you must clone the repo and then execute the install.sh file. 
This script will update and upgrade your OS. 
If you want to install the nerd font (I use ComicShannsMono) you can do it easily with the script, you will have a prompt asking if you want to. If you connect to your server with ssh a nerd font should be installed on the computer you're connecting with. 
Then ZSH will be used as the default terminal and starship will be installed and configured.
I invite you to check the script by yourself to understand any further. 

The starship website can be found here : https://starship.rs if you want to add any other modules to your configuration file. 
The Nerd Fonts website can be found here : https://www.nerdfonts.com/ or here https://github.com/ryanoasis/nerd-fonts (for the install) if you want to change the font you want to install you can edit the script. Some icons can also be found there if you want to modify the icons I put there. 

The script will ask you if you want to reboot your system now or later. I recommend you to reboot as soon as possible.

I always do my best to keep my repos updated but if you see an error in the script you can contact me. 
Credits to christan lempa who initially did the config files. I modified almost all of theses files and then created a script in order to automate the installation.

Here is an overview of what your terminal will look like. 

Ubuntu :
<img width="1335" alt="Screenshot 2023-06-09 at 20 47 54" src="https://github.com/NeevChandiramani/StarshipScript/assets/102186419/bb6ae732-1a0a-4c75-9294-369f8bf1e71c">

Debian :

<img width="1575" alt="Screenshot 2023-06-09 at 20 53 38" src="https://github.com/NeevChandiramani/StarshipScript/assets/102186419/f1dbde7b-9a4e-4265-a598-19118a933889">

The terminal used is warp with a special theme that you can find here : https://github.com/ChristianLempa/dotfiles/blob/main/.warp/themes/xcad2k_dark.yml.