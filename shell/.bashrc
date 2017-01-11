if [ -f $HOME/.profile ]
then
    source $HOME/.profile
fi

# Use the system config if it exists
if [ -f /etc/bashrc ]; then
    . /etc/bashrc        # --> Read /etc/bashrc, if present.
elif [ -f /etc/bash.bashrc ]; then
    . /etc/bash.bashrc   # --> Read /etc/bash.bashrc, if present.
fi

[[ $- = *i* ]] || return

_LIQUIDPROMPT=$HOME/.antigen/repos/https-COLON--SLASH--SLASH-github.com-SLASH-nojhan-SLASH-liquidprompt.git/liquidprompt;
if [ -f $_LIQUIDPROMPT ]
then
    source $_LIQUIDPROMPT
fi

# Aliases
alias ls='ls --color'
alias l=ls
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'

alias g=git
alias o=mimeopen
