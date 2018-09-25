# Check if zpacker is installed
if [[ ! -d "$HOME/.zpacker" ]]; then
    git clone https://github.com/happyslowly/zpacker $HOME/.zpacker
fi

# Load zplug
source $HOME/.zpacker/zpacker.zsh

zpacker plugin zsh-users/zsh-syntax-highlighting
zpacker plugin zsh-users/zsh-history-substring-search

# Utilities

# z, like fasd
zpacker plugin rupa/z

# sysadmin utilities
zpacker plugin skx/sysadmin-util

# Load more completion files for zsh from the zsh-lovers github repo.
zpacker plugin zsh-users/zsh-completions src

# 256 colors support
zpacker plugin chrissicool/zsh-256color

# Theme
#
# load git plugin from oh-my-zsh
zpacker plugin 'robbyrussell/oh-my-zsh' lib/git.zsh

#zpacker theme happyslowly/clean
zpacker plugin andrepolischuk/min

zpacker end

###############
# ZSH Options #
###############

# no c-s/c-q output freezing
setopt noflowcontrol

# allow expansion in prompts
setopt prompt_subst

# display PID when suspending processes as well
setopt longlistjobs

# try to avoid the 'zsh: no matches found...'
setopt nonomatch

# report the status of backgrounds jobs immediately
setopt notify

# whenever a command completion is attempted, make sure the entire command path
# is hashed first.
setopt hash_list_all

# not just at the end
setopt completeinword

# use zsh style word splitting
setopt noshwordsplit

# allow use of comments in interactive code
setopt interactivecomments

# in order to use #, ~ and ^ for filename generation grep word
# *~(*.gz|*.bz|*.bz2|*.zip|*.Z) -> searches for word not in compressed files
# don't forget to quote '^', '~' and '#'!
setopt extended_glob

# don't error out when unset parameters are used
setopt unset

# watch for everyone but me and root
watch=(notme root)

# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath

# if a command is issued that can't be executed as a normal command, and the
# command is the name of a directory, perform the cd command to that directory.
setopt auto_cd

# Don't send SIGHUP to background processes when the shell exits.
setopt nohup

# make cd push the old directory onto the directory stack.
setopt auto_pushd

# avoid "beep"ing
setopt nobeep

# don't push the same dir twice.
setopt pushd_ignore_dups

# * shouldn't match dotfiles. ever.
setopt noglobdots

###########
# History #
###########

[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zhistory"
HISTSIZE=50000
SAVEHIST=10000

## History command configuration
setopt extended_history         # record timestamp of command in HISTFILE
setopt hist_expire_dups_first   # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups         # ignore duplicated commands history list
setopt hist_ignore_space        # ignore commands that start with space
setopt hist_verify              # show command with history expansion to user before running it
setopt inc_append_history       # add commands to HISTFILE in order of execution
setopt share_history            # share command history data

# terminfo hash
zmodload zsh/terminfo

# History substring keybindings
bindkey -M emacs "\C-P" history-substring-search-up
bindkey -M emacs "\C-N" history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
# up/down keys
for keymap in 'emacs' 'viins'; do
    bindkey -M "$keymap" "$terminfo[kcuu1]" history-substring-search-up
    bindkey -M "$keymap" "$terminfo[kcud1]" history-substring-search-down
done
#

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

# Set GOPATH for Go
if command -v go &> /dev/null; then
    [ -d "$HOME/lib" ] || mkdir "$HOME/lib"
    export GOPATH="$HOME/lib"
    export PATH="$PATH:$GOPATH/bin"
fi

# Cargo/Rust PATH
if command -v cargo &> /dev/null; then
    [ -d "$HOME/.cargo" ] || mkdir -p "$HOME/.cargo/bin"
    export PATH="$PATH:$HOME/.cargo/bin"
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

# Pacman
alias pac=yay

### END
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh