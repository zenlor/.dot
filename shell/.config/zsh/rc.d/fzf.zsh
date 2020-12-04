#!/bin/zsh

if type 'fzf' > /dev/null; then

    if [[ ! -d ~/.cache/fzf ]]; then
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.cache/fzf
    fi

    if [[ $- == *i* ]]; then
        source "${HOME}/.cache/fzf/shell/completion.zsh" 2> /dev/null
    fi
    source "${HOME}/.cache/fzf/shell/key-bindings.zsh"

    export FZF_DEFAULT_OPS='--extended'
    export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"

    # If fd command is installed, use it instead of find
    if type 'fd' > /dev/null; then
        export FZF_DEFAULT_COMMAND='fd --type f'
    fi

    if [[ -d ~/.cache/fzf/man ]]; then
        export MANPATH="$MANPATH:~/.cache/fzf/man"
    fi
fi
