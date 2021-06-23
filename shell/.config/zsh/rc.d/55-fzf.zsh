#!/bin/zsh

if [[ $- == *i* ]]; then
    if type 'fzf' > /dev/null; then

        if [[ -f ${HOME}/.nix-profile/share/fzf/key-bindings.zsh ]]; then
            FZF_SHARE="${HOME}/.nix-profile/share/fzf"
        else
            if [[ ! -d ${HOME}/.cache/fzf ]]; then
                git clone --depth 1 https://github.com/junegunn/fzf.git ${HOME}/.cache/fzf
            fi

            FZF_SHARE="${HOME}/.cache/fzf/shell"
        fi

        source "${FZF_SHARE}/completion.zsh" 2> /dev/null
        source "${FZF_SHARE}/key-bindings.zsh"


        export FZF_DEFAULT_OPS='--extended'
        export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"

        # If fd command is installed, use it instead of find
        if type 'fd' > /dev/null; then
            export FZF_DEFAULT_COMMAND='fd --type f'
        fi

        # if [[ -d ~/.cache/fzf/man ]]; then
        #     export MANPATH="$MANPATH:~/.cache/fzf/man"
        # fi
    fi

    enable-fzf-tab
fi
