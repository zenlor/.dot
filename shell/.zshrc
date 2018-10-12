# Check if zgen is installed
if [[ ! -d "${ZGEN_DIR}" ]]; then
    git clone https://github.com/tarjoilija/zgen.git "${ZGEN_DIR}"
fi

# load zgen
source "${ZGEN_DIR}/zgen.zsh"

# if the init scipt doesn't exist
if ! zgen saved; then
    echo "zgen init"

    zgen oh-my-zsh

    # plugins
    zgen oh-my-zsh plugins/vim
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/sudo
    zgen oh-my-zsh plugins/command-not-found
    zgen oh-my-zsh plugins/syntax-highlighting
    zgen oh-my-zsh plugins/history
    zgen oh-my-zsh plugins/history-substring-search

    # completions
    zgen load zsh-users/zsh-completions src

    # autoenv
    zgen load Tarrasch/zsh-autoenv

    # z, like fasd
    zgen load rupa/z

    # 256 colors
    zgen load chrissicool/zsh-256color

    # theme
    zgen load andrepolischuk/min

    # save all to init script
    zgen save
fi

# vi mode
bindkey -v
KEYTIMEOUT=1

#
# Environment settings
#

# Enable keychain
if command -v keychain &> /dev/null; then
    eval `keychain --eval --quiet --agents ssh id_rsa id_frenzart.com`
fi

###########
# aliases #
###########

# Enable color support
ls --color -d . &> /dev/null && alias ls='ls --color=auto' || alias ls='ls -G'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Some more basic aliases
alias sl=ls
alias ll='ls -lh'
alias la='ls -lAh'
alias l='ls -lah'

# Git
alias git='noglob git'

# xdg-open
alias open='xdg-open'

# emacs client
#   no wait
alias ec='emacsclient -n'
#   create new frame
alias ecc='emacsclient -n -c'

# Simple HTTP server
function server() {
    local port="${1:-8000}"
    open "http://localhost:${port}/"
    python -m http.server "$port"
}
alias server=server

# ipaddresses
function ipaddresses() {
    ip addr | awk '/[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\./ {sub(/addr:/,""); print $2 }'
}
alias ipaddresses=ipaddresses

# Pacman
alias pac=yay

# htop
alias htopu="htop -u $USER"

# neovim
if command -v nvim &> /dev/null; then
    alias vim=nvim
fi

### END
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /home/lor/lib/src/git.mobilebridge.io/eventstream/event-sourcery/node_modules/tabtab/.completions/serverless.zsh ]] && . /home/lor/lib/src/git.mobilebridge.io/eventstream/event-sourcery/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /home/lor/lib/src/git.mobilebridge.io/eventstream/event-sourcery/node_modules/tabtab/.completions/sls.zsh ]] && . /home/lor/lib/src/git.mobilebridge.io/eventstream/event-sourcery/node_modules/tabtab/.completions/sls.zsh