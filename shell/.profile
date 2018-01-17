
# Set pacman to powerpill
pacman -Q powerpill >& /dev/null && export PACMAN=/usr/bin/powerpill

export EDITOR='nvim'
export GIT_EDITOR='/usr/bin/nvim'
export BROWSER="$HOME/lib/bin/browser"
export PAGER='/usr/bin/most'

# export TMPDIR
export TMPDIR=/tmp/$USER
mkdir -p $TMPDIR

# Local binpaths
[ -d "$HOME/bin" ] && export PATH=$HOME/bin:$PATH
[ -d "$HOME/lib/bin" ] && export PATH=$HOME/lib/bin:$PATH
[ -d "$HOME/.local/bin" ] && export PATH=$HOME/.local/bin:$PATH

# Go
[ -d "$HOME/lib" ] && export GOPATH=$HOME/lib

# N(ode version manager)
export N_PREFIX=$HOME/lib/n
[ -d "$N_PREFIX/bin" ] && export PATH=$N_PREFIX/bin:$PATH

# if rbenv is present, configure it for use
if [ -d $HOME/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:${PATH}"
  eval "$(rbenv init -)"
fi

# Add RVM to PATH for scripting, if rvm is present
if which rvm-prompt &> /dev/null; then
  export PATH="$HOME/.rvm/bin:$PATH"
fi

# If Jenv exists, add it to PATH and init
if [ -d $HOME/.jenv ]; then
  export PATH="$HOME/.jenv/bin:$PATH"
  eval "$(jenv init -)"
fi

# PHP ... when I need to do crap
export PATH="$PATH:$HOME/.config/composer/vendor/bin"

# Local env
export PATH="$PATH:$HOME/bin:~/.local/bin"

# Window managers
[[ "$XDG_CURRENT_DESKTOP" == "KDE" ]] || [[ "$XDG_CURRENT_DESKTOP" == "GNOME" ]] || export QT_QPA_PLATFORMTHEME="qt5ct"
