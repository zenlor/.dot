# load zgen
source "${HOME}/.zgen/zgen.zsh"

# if the init scipt doesn't exist
if ! zgen saved; then

    # specify plugins here
    zgen oh-my-zsh
    zgen oh-my-zsh plugins/dotenv
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/sudo
    zgen oh-my-zsh plugins/fasd
    zgen oh-my-zsh plugins/vi-mode
    zgen oh-my-zsh plugins/command-not-found
    zgen oh-my-zsh plugins/history-substring-search
    zgen oh-my-zsh plugins/tmux

    zgen load eendroroy/alien-minimal
    zgen load zsh-users/zsh-syntax-highlighting

    # generate the init script from plugins above
    zgen save
fi

#
# Aliases
#
alias pac=trizen
