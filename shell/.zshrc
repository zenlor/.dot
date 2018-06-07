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
    zgen oh-my-zsh plugins/pass
    zgen oh-my-zsh plugins/vi-mode
    zgen oh-my-zsh plugins/command-not-found
    zgen oh-my-zsh plugins/history-substring-search

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
alias pac=yay
alias htopu="htop -u $USER"
alias ec="emacsclient --no-wait"
alias vim=nvim

alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
alias ll='ls -l'      #long list