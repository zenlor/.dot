# Can be sourced by zsh/bash/sh scripts

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_BIN_HOME="$HOME/.local/bin"

if [ ! -d "$XDG_CACHE_HOME" ]; then
    mkdir -p \
        "$XDG_CACHE_HOME" \
        "$XDG_CONFIG_HOME" \
        "$XDG_DATA_HOME" \
        "$XDG_BIN_HOME"
fi

## source osx path_helper
if [ -x /usr/libexec/path_helper ]; then
    eval $(/usr/libexec/path_helper -s)
fi

## source system profile
#if [ -f /etc/profile.d ]; then
#    for i in /etc/profile.d/*.sh; do
#        . $i
#    done
#fi

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
[ -d $HOME/.nix-defexpr ] && export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH || true

## PATH
export PATH=/nix/var/nix/profiles/per-user/$USER/profile/bin:$PATH
export PATH=$HOME/lib/n/bin:$HOME/lib/bin:$HOME/.local/bin:$PATH

## TDM
#[ "$(tty)" = '/dev/tty1' ] &&\
#    [ -z "$DISPLAY$SSH_TTY$(pgrep xinit)" ] &&\
#    exec tdm


# Applications

# go: Set GOPATH for Go
if command -v go &> /dev/null; then
    [ -d "$HOME/lib/bin" ] || mkdir -p "$HOME/lib/bin"
    export GOPATH="$HOME/lib"
    export PATH="$PATH:$GOPATH/bin"
fi

# rust/cargo: Cargo/Rust PATH
if command -v cargo &> /dev/null; then
    [ -d "$HOME/.cargo" ] || mkdir -p "$HOME/.cargo/bin"
    export PATH="$PATH:$HOME/.cargo/bin"
fi

# Microsoft bugs: WSL1
if uname -r|grep -q Microsoft;then
    export DISPLAY=:0
    export LIBGL_ALWAYS_INDIRECT=1

    # See https://github.com/Microsoft/BashOnWindows/issues/1887
    unsetopt BG_NICE
# Microsoft bugs: WSL2
elif uname -r|grep -q microsoft;then
    export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
fi

# lua: luarocks PATH
if command -v luarocks &> /dev/null; then
    [ -d "$HOME/.luarocks/bin" ] || mkdir -p "$HOME/.luarocks/bin"
    export PATH="$PATH:$HOME/.luarocks/bin"
fi

## GPG tty fix
export GPG_TTY=$(tty)

export LC_ALL=en_US.UTF-8

## Load local configuration
[ -f "$HOME/.profile.local" ] && source "$HOME/.profile.local" || true

# doom
[ -f "$HOME/.emacs.d/bin/doom" ] && export PATH="$PATH:$HOME/.emacs.d/bin" || true

# MacOSX python
[ -d "$HOME/Library/Python/3.9/bin" ] && export PATH="$PATH:$HOME/Library/Python/3.9/bin" || true

# fzf settings
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_CTRL_R_OPTS=""
export FZF_DEFAULT_OPTS='--no-height --no-reverse
--color fg:242,hl:65,fg+:15,bg+:234,hl+:108
--color info:108,prompt:109,spinner:108,pointer:168,marker:168'

# keychain
if command -v keychain &> /dev/null; then
    eval `keychain --eval --quiet --agents ssh,gpg $SSH_AGENT_KEYS $GPG_AGENT_KEYS`

    cat <<EOF > ~/.ssh/.env
SSH_AUTH_SOCK=$SSH_AUTH_SOCK
SSH_AGENT_PID=$SSH_AGENT_PID
GPG_AGENT_KEYS=$GPG_AGENT_KEYS
GPG_AGENT_INFO=$GPG_AGENT_INFO
EOF
fi

# vim:ft=sh
