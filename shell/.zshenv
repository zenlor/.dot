# disable global zsh config; we'll handle it ourselves
unsetopt GLOBAL_RCS

source ~/.profile

# paths
typeset -gU cdpath fpath mailpath path
path=( $XDG_BIN_HOME $HOME/lib/bin $HOME/lib/n/bin $path )
fpath=( $ZDOTDIR/functions $XDG_BIN_HOME $fpath )

# envvars
export LANG=${LANG:-en_US.UTF-8}
export PAGER=less
export LESS='-R -i -w -M -z-4'
export LESSHISTFILE="$XDG_DATA_HOME/lesshistory"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"



if [ -f /usr/local/opt/findutils/libexec/gnubin/find ]; then
    export PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH";
fi
