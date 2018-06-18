# Check if zplug is installed
if [[ ! -d "$HOME/.zgen" ]]; then
    git clone https://github.com/tarjoilija/zgen.git "$HOME/.zgen"
fi

# Load zplug
source $HOME/.zgen/zgen.zsh

if ! zgen saved; then
    # prezto and modules
    zgen prezto editor key-bindings 'vi'
    zgen prezto editor dot-expansion 'yes'
    zgen prezto prompt theme 'nicoulaj'
    zgen prezto tmux:auto-start remote 'yes'
    zgen prezto terminal auto-tile 'yes'

    zgen prezto
    zgen prezto git
    zgen prezto command-not-found
    zgen prezto syntax-highlighting
    zgen prezto history
    zgen prezto history-substring-search
    zgen prezto utility
    zgen prezto completion
    zgen prezto fasd
    zgen prezto tmux
    zgen prezto terminal

    zgen load "zsh-users/zaw"
    zgen load "termoshtt/zaw-systemd"

    zgen save
fi

# Check if reboot is required for Ubuntu
if [ -f /usr/lib/update-notifier/update-motd-reboot-required ]; then
    function reboot-required() {
        /usr/lib/update-notifier/update-motd-reboot-required
    }
fi

# Enable keychain
if command -v keychain &> /dev/null; then
    eval `keychain --eval --quiet --agents ssh id_rsa`
fi

# Set GOPATH for Go
if command -v go &> /dev/null; then
    [ -d "$HOME/lib" ] || mkdir "$HOME/lib"
    export GOPATH="$HOME/lib"
    export PATH="$PATH:$GOPATH/bin"
fi

# Bindkeys
#
# zaw
bindkey '^R' zaw-history
bindkey '^T' zaw-tmux

# Define aliases
# Enable color support
ls --color -d . &> /dev/null && alias ls='ls --color=auto' || alias ls='ls -G'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Some more basic aliases
alias ll='ls -lh'
alias la='ls -lAh'
alias l='ls -lah'
alias md='mkdir -p'
alias rd='rmdir'
alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'
alias cd.....='cd ../../../..'
alias cd......='cd ../../../../..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# Git
alias git='noglob git'

# Vim
alias v='nvim'
alias vi='vim'
alias vim='nvim'

# pacman
alias pac='yay'

# emacs client
#   no wait
alias ec='emacsclient -n'
#   create new frame
alias ecc='emacsclient -n -c'

# Simple HTTP server
function server() {
    local port="${1:-8000}"
    open "http://localhost:${port}/"
    python -m SimpleHTTPServer "$port"
}

alias server=server

# Source local zshrc
if [ -f "$HOME/.zshrc.local" ]; then
    source "$HOME/.zshrc.local"
fi
