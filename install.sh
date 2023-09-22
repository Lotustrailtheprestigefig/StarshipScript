#!/bin/bash

# Update the system
echo "Updating the system..."
apt update && apt upgrade -y
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
home_symbol = " ~"
read_only_style = "197"
read_only = "  "
format = "at [\$path](\$style)[\$read_only](\$read_only_style) "

[git_branch]
symbol = " "
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
diverged = "⇕⇡\${ahead_count}⇣\${behind_count}"
behind = "⇣\${count}"
stashed = " "
modified = " "
staged = '[++\(\$count\)](green)'
renamed = "襁 "
deleted = " "

[kubernetes]
format = 'via [ﴱ \$context(\$namespace)](bold purple) '
disabled = false

[username]
disabled = true

[vagrant]
disabled = true

[docker_context]
disabled = true

[helm]
disabled = true

[python]
disabled = true

[nodejs]
disabled = true

[ruby]
disabled = true

[terraform]
disabled = true

[localip]
ssh_only = false
format = '@[\$localipv4](bold red) '
disabled = false

[memory_usage]
disabled = false
threshold = -1
symbol = ' '
style = 'bold dimmed green'

EOF
echo "starship.toml configuration file created."

# Append additional configuration to /etc/zsh/zshrc
echo "Adding additional configuration to /etc/zsh/zshrc..."
cat <<'EOF' >> /etc/zsh/zshrc
# Useful support for interacting with Terminal.app or other terminal programs
[ -r "/etc/zshrc_$TERM_PROGRAM" ] && . "/etc/zshrc_$TERM_PROGRAM"
[[ -f ~/.zsh/aliases.zsh ]] && source ~/.zsh/aliases.zsh
[[ -f ~/.zsh/functions.zsh ]] && source ~/.zsh/functions.zsh
[[ -f ~/.zsh/starship.zsh ]] && source ~/.zsh/starship.zsh
[[ -f ~/.zsh/nvm.zsh ]] && source ~/.zsh/nvm.zsh
[[ -f ~/.zsh/wsl2fix.zsh ]] && source ~/.zsh/wsl2fix.zsh
#[[ -f ~/.zsh/goto.zsh ]] && source ~/.zsh/goto.zsh
# Load Direnv
#eval "$(direnv hook zsh)"
eval "$(starship init zsh)"
EOF
echo "Additional configuration added to /etc/zsh/zshrc."

# Create .zsh directory in the home folder
echo "Creating .zsh directory..."
mkdir -p ~/.zsh
echo ".zsh directory created."

# Create aliases.zsh file
echo "Creating aliases.zsh file..."
cat <<'EOF' > ~/.zsh/aliases.zsh
# Alias
# ---
#
alias k="kubectl"
alias h="helm"
alias tf="terraform"
alias a="ansible"
alias ap="ansible-playbook"
alias dt="datree"

# mac OS shortcuts
alias code="open -a 'Visual Studio Code'"

# ALIAS COMMANDS
alias ls="exa --icons --group-directories-first"
alias ll="exa --icons --group-directories-first -l"
alias g="goto"
alias grep='grep --color'

alias cbp="code /home/xcad/obsidianvault/boilerplates"
alias cpr="code /home/xcad/obsidianvault/projects"

# Scripts
alias repos="op run --env-file="/Users/xcad/.env" -- python3 /Users/xcad/Projects/christianlempa/scripts/repos"
EOF
echo "aliases.zsh file created."

# Create functions.zsh file
echo "Creating functions.zsh file..."
cat <<'EOF' > ~/.zsh/functions.zsh
# Colormap
function colormap() {
  for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
}
EOF
echo "functions.zsh file created."

# Create goto.zsh file
echo "Creating goto.zsh file..."
cat <<'EOF' > ~/.zsh/goto.zsh
autoload -Uz compinit
compinit

source $(brew --prefix)/etc/bash_completion.d/goto.sh
EOF
echo "goto.zsh file created."

# Create nvm.zsh file
echo "Creating nvm.zsh file..."
cat <<'EOF' > ~/.zsh/nvm.zsh
# NVM lazy load
if [ -s "$HOME/.nvm/nvm.sh" ]; then
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
  alias nvm='unalias nvm node npm && . "$NVM_DIR"/nvm.sh && nvm'
  alias node='unalias nvm node npm && . "$NVM_DIR"/nvm.sh && node'
  alias npm='unalias nvm node npm && . "$NVM_DIR"/nvm.sh && npm'
fi
EOF
echo "nvm.zsh file created."

# Create starship.zsh file
echo "Creating starship.zsh file..."
cat <<'EOF' > ~/.zsh/starship.zsh
# find out which distribution we are running on
LFILE="/etc/*-release"
MFILE="/System/Library/CoreServices/SystemVersion.plist"
if [[ -f $LFILE ]]; then
  _distro=$(awk '/^ID=/' /etc/*-release | awk -F'=' '{ print tolower($2) }')
elif [[ -f $MFILE ]]; then
  _distro="macos"

  # on mac os use the systemprofiler to determine the current model
  _device=$(system_profiler SPHardwareDataType | awk '/Model Name/ {print $3,$4,$5,$6,$7}')

  case $_device in
    *MacBook*)     DEVICE="";;
    *mini*)        DEVICE="󰇄";;
    *)             DEVICE="";;
  esac
else
  _distro=$( uname -v | tr '[:upper:]' '[:lower:]')
fi

# set an icon based on the distro
# make sure your font is compatible with https://github.com/lukas-w/font-logos
case $_distro in
    *kali*)                  ICON="ﴣ";;
    *arch*)                  ICON="";;
    *debian*)                ICON="";;
    *raspbian*)              ICON="";;
    *ubuntu*)                ICON="";;
    *elementary*)            ICON="";;
    *fedora*)                ICON="";;
    *coreos*)                ICON="";;
    *gentoo*)                ICON="";;
    *mageia*)                ICON="";;
    *centos*)                ICON="";;
    *opensuse*|*tumbleweed*) ICON="";;
    *sabayon*)               ICON="";;
    *slackware*)             ICON="";;
    *linuxmint*)             ICON="";;
    *alpine*)                ICON="";;
    *aosc*)                  ICON="";;
    *nixos*)                 ICON="";;
    *devuan*)                ICON="";;
    *manjaro*)               ICON="";;
    *rhel*)                  ICON="";;
    *macos*)                 ICON="";;
    *)                       ICON="";;
esac

export STARSHIP_DEVICE=$DEVICE
export STARSHIP_DISTRO=$ICON
EOF
echo "starship.zsh file created."

# Create wsl2fix.zsh file
echo "Creating wsl2fix.zsh file..."
cat <<'EOF' > ~/.zsh/wsl2fix.zsh
if [[ "$(uname -r)" == *Microsoft ]]; then
    bindkey -m emacs '^?' backward-delete-char
    bindkey -m viins '^?' backward-delete-char
    bindkey -m vi-command '^?' backward-delete-char
    bindkey -m isearch '^?' backward-delete-char

    alias code='code.cmd'
fi
EOF
echo "wsl2fix.zsh file created."

# Source the ~/.zshrc file
echo "Sourcing the ~/.zshrc file..."
source /etc/zsh/zshrc
echo "Installation complete."
sleep 2

# Ask if the user wants to reboot
read -p "Installation complete. Do you want to reboot the system now? [y/n]: " reboot_choice

if [[ $reboot_choice == "y" || $reboot_choice == "Y" ]]; then
    echo "Rebooting the system..."
    sudo reboot
else
    echo "Installation complete. Please reboot the system to apply the changes."
fi
