# load zgen
source "${HOME}/.zgen/zgen.zsh"

# if the init scipt doesn't exist
if ! zgen saved; then

    # specify plugins here
    zgen oh-my-zsh
    zgen oh-my-zsh plugins/dotenv
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/sudo
    zgen oh-my-zsh plugins/asdf
    zgen oh-my-zsh plugins/fasd
    zgen oh-my-zsh plugins/vi-mode
    zgen oh-my-zsh plugins/command-not-found
    zgen oh-my-zsh plugins/history-substring-search
    zgen oh-my-zsh plugins/tmux

    zgen load eendroroy/alien-minimal
    zgen load chrissicool/zsh-256color
    zgen load zdharma/fast-syntax-highlighting
    zgen load zsh-users/zsh-completions

    # generate the init script from plugins above
    zgen save
fi

#
# Keychain
#
keychain --quiet id_rsa id_frenzart.com
[ -z "$HOSTNAME" ] && HOSTNAME=`uname -n`
[ -f $HOME/.keychain/$HOSTNAME-sh ] && \
    . $HOME/.keychain/$HOSTNAME-sh
[ -f $HOME/.keychain/$HOSTNAME-sh-gpg ] && \
    . $HOME/.keychain/$HOSTNAME-sh-gpg

#
# Aliases
#
alias pac=trizen
alias htopu="htop -u $USER"
alias ec="$ZSH/plugins/emacs/emacsclient.sh --no-wait"
