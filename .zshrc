ZSH="$HOME/.oh-my-zsh"

# Setup theme
ZSH_THEME=""

# Setup plugins
plugins=(git zsh-autosuggestions zsh-vi-mode)
source $ZSH/oh-my-zsh.sh

# Setup zsh vi keybinds
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk

# Startup Starship
eval "$(starship init zsh)"

# Startup ASDFK package manager
. "$HOME/.asdf/asdf.sh"

# set JAVA_HOME
. ~/.asdf/plugins/java/set-java-home.zsh

# Run neofetch
neofetch
