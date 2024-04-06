# StarshipScript

StarshipScript is a standard script designed to transform your original terminal into a new, visually appealing terminal with some nice icons. This script is specifically for Linux operating systems.

## Installation

To install StarshipScript, you must be logged in as a root user. Follow these steps:

1. Clone this repository.
2. Execute the `install.sh` file.

This script will update and upgrade your OS. 

## Nerd Font

If you want to install the nerd font (ComicShannsMono is used here), you can do it easily with the script. You will be prompted to install it. If you connect to your server with ssh, a nerd font should be installed on the computer you're connecting with. 

## Terminal and Starship

After the installation, ZSH will be used as the default terminal and starship will be installed and configured. 

For more information on Starship, visit the [Starship website](https://starship.rs). If you want to add any other modules to your configuration file, you can do so from there.

For more information on Nerd Fonts, visit the [Nerd Fonts website](https://www.nerdfonts.com/) or the [Nerd Fonts GitHub page](https://github.com/ryanoasis/nerd-fonts). If you want to change the font you want to install, you can edit the script. Some icons can also be found there if you want to modify the icons used in this script.

## Reboot

The script will ask you if you want to reboot your system now or later. It is recommended to reboot as soon as possible.

## Credits

Credits to Christian Lempa who initially created the config files. These files have been modified and a script has been created to automate the installation.

## Preview

Here is an overview of what your terminal will look like:

Ubuntu:
![Ubuntu Preview](https://github.com/NeevChandiramani/StarshipScript/assets/102186419/bb6ae732-1a0a-4c75-9294-369f8bf1e71c)

Debian:
![Debian Preview](https://github.com/NeevChandiramani/StarshipScript/assets/102186419/f1dbde7b-9a4e-4265-a598-19118a933889)

On iterm2:
![iterm2 Preview](https://github.com/NeevChandiramani/StarshipScript/assets/102186419/40f3b2e3-1643-402e-8e36-e4c835634f4b)

The terminal used is warp with a special theme that you can find [here](https://github.com/ChristianLempa/dotfiles/blob/main/.warp/themes/xcad2k_dark.yml).