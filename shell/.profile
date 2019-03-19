# Can be sourced by zsh/bash/sh scripts

export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_BIN_HOME=$HOME/.local/bin

export DOTFILES="$(cd $(dirname "${BASH_SOURCE:-${(%):-%x}}") && pwd -P)"
export DOTFILES_DATA="$XDG_DATA_HOME/dotfiles"
export DOTFILES_ASSETS="$DOTFILES/assets"

for dir in "$XDG_CACHE_HOME" "$XDG_CONFIG_HOME" "$XDG_DATA_HOME" "$XDG_BIN_HOME" "$DOTFILES_DATA"; do
  [[ -d $dir ]] || mkdir -p "$dir"
done

## source osx path_helper
if [ -x /usr/libexec/path_helper ]; then
    eval `/usr/libexec/path_helper -s`
fi

## source system profile
if [ -d /etc/profile.d ]; then
    for i in /etc/profile.d/*.sh; do
        source $i
    done
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


## PATH
export PATH=$HOME/lib/n/bin:$HOME/lib/bin:$HOME/.local/bin:$PATH

## Library
function _is_interactive { [ $- == *i* ]; }

function _is_running {
  for prc in "$@"; do
    pgrep -x "$prc" >/dev/null || return 1
  done
}

function _source {
  [ -f $1 ] && source "$1"
}

## TDM
[[ "$(tty)" == '/dev/tty1' ]] &&\
    [[ -z "$DISPLAY$SSH_TTY$(pgrep xinit)" ]] &&\
    exec tdm

## GPG tty fix
export GPG_TTY=$(tty)

export LC_ALL=en_US.UTF-8

# vim:ft=sh
