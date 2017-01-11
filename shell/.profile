
export EDITOR='nvim'
export GIT_EDITOR='/usr/bin/nvim'
export BROWSER="$HOME/lib/bin/browser"
export TERMINAL=termite

# export TMPDIR
export TMPDIR=/tmp/$USER
mkdir -p $TMPDIR

# Local binpaths
[ -d "$HOME/bin" ] && export PATH=$HOME/bin:$PATH
[ -d "$HOME/lib/bin" ] && export PATH=$HOME/lib/bin:$PATH

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

# Node Project Manager Init
if which npm &> /dev/null; then
  eval "$(npm completion -)"
fi

export PATH=$PATH:$HOME/bin:~/.local/bin
