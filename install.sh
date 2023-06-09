#!/bin/bash

# Update the system
echo "Updating the system..."
apt update
echo "System update complete."

# Ask if the user wants to install the "next generation terminal"
read -p "Do you want to install the next generation terminal? [y/n]: " install_terminal

if [[ $install_terminal == "y" || $install_terminal == "Y" ]]; then
    echo "Installing ZSH..."
    sudo apt install zsh -y
    echo "ZSH installed."

    echo "Changing the default shell to ZSH..."
    chsh -s $(which zsh)
    echo "Default shell changed to ZSH."
fi

# Continue with the remaining installation steps
echo "Installing exa..."
apt install exa -y
echo "exa installed."

echo "Installing Git..."
apt install git -y
echo "Git installed."

# Ask if the user wants to install the Nerd Font
read -p "Do you want to install the Nerd Font? [y/n]: " install_nerd_font

if [[ $install_nerd_font == "y" || $install_nerd_font == "Y" ]]; then
    echo "Installing Nerd Font..."
    git clone https://github.com/ryanoasis/nerd-fonts.git
    cd nerd-fonts
    ./install ComicShannsMono
    cd ..
    echo "Nerd Font installed."
fi

# Install Starship
echo "Installing Starship..."
curl -sS https://starship.rs/install.sh | sh
echo "Starship installed."

# Add Starship configuration to ~/.zshrc
echo "Configuring Starship..."
echo 'eval "$(starship init zsh)"' >> ~/.zshrc
echo "Starship configuration added to ~/.zshrc."

# Create starship.toml configuration file
echo "Creating starship.toml configuration file..."
mkdir -p ~/.config && touch ~/.config/starship.toml
cat <<EOF > ~/.config/starship.toml
# ~/.config/starship.toml

add_newline = true
command_timeout = 1000
format = "\$env_var \$all"

[character]
success_symbol = ""
error_symbol = ""

[env_var.STARSHIP_DISTRO]
format = '[\$env_value](bold white) '
variable = "STARSHIP_DISTRO"
disabled = false

[env_var.USER]
format = '[\$env_value](bold white) '
variable = "USER"
disabled = false

[env_var.STARSHIP_DEVICE]
format = 'on [\$env_value](bold yellow)'
variable = "STARSHIP_DEVICE"
disabled = false

[hostname]
ssh_only = false
format = "[\$hostname](bold yellow) "
disabled = false

[directory]
truncation_length = 1
truncation_symbol = "…/"
home_symbol = " ~"
read_only_style = "197"
read_only = "  "
format = "at [\$path](\$style)[\$read_only](\$read_only_style) "

[git_branch]
symbol = " "
format = "via [\$symbol\$branch](\$style) "
truncation_symbol = "…/"
style = "bold green"

[git_status]
format = '[\(\$all_status\$ahead_behind\)](\$style) '
style = "bold green"
conflicted = "🏳"
up_to_date = " "
untracked = " "
ahead = "⇡\${count}"
diverged = "⇕\${count}"
behind = "⇣\${count}"
stashed = "💾 "
modified = "\${count}"
staged = "✚\${count}"
renamed = "➜\${count}"
deleted = "✖\${count}"

[cmd_duration]
format = "took [\$duration](bold yellow) "

[custom.foo]
description = "An example custom prompt segment"
format = "says [\"hello! \"](bold green)"

[custom.foo.env_var]
format = "(\$value)"
variable = "MY_VAR"
EOF
echo "starship.toml configuration file created."

# Add additional configuration to /etc/zsh/zshrc
echo "Adding additional configuration to /etc/zsh/zshrc..."
cat <<EOF | sudo tee -a /etc/zsh/zshrc
# Load custom configurations
for config_file ($HOME/.zsh/*.zsh); do
    source "\$config_file"
done
EOF
echo "Additional configuration added to /etc/zsh/zshrc."

# Create additional files in ~/.zsh directory
echo "Creating additional files in ~/.zsh directory..."
mkdir -p ~/.zsh
touch ~/.zsh/aliases.zsh
touch ~/.zsh/functions.zsh
touch ~/.zsh/goto.zsh
touch ~/.zsh/nvm.zsh
touch ~/.zsh/starship.zsh
echo "Additional files created in ~/.zsh directory."

# Source the ~/.zshrc file to apply changes
echo "Sourcing ~/.zshrc file..."
source ~/.zshrc
echo "Changes applied."

# Ask if the user wants to reboot the system
read -p "Do you want to reboot the system? [y/n]: " reboot_system

if [[ $reboot_system == "y" || $reboot_system == "Y" ]]; then
    echo "Rebooting the system..."
    reboot
else
    echo "Script execution completed."
fi
