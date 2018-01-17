# fzf
#
if [ -x "$(which fzf)" ]; then
    #
    # Key Bindings
    #
    source "/usr/share/fzf/key-bindings.zsh"
    #
    # Completion
    #
    source "/usr/share/fzf/completion.zsh"

    #
    # Default options
    #
    export FZF_DEFAULT_OPTS='
    --color fg:-1,bg:-1,hl:230,fg+:3,bg+:233,hl+:229
    --color info:150,prompt:110,spinner:150,pointer:167,marker:174
    '

    # pass completion suggested by @d4ndo (#362)
    function _fzf_complete_pass() {
        _fzf_complete '+m' "$@" < <(
            pwdir=${PASSWORD_STORE_DIR-~/.password-store/}
            stringsize="${#pwdir}"
            find "$pwdir" -name "*.gpg" -print |
                cut -c "$((stringsize + 1))"-  |
                sed -e 's/\(.*\)\.gpg/\1/'
        )
    }


    # fzf-z
    __fzfz() {
        if (($+FZFZ_EXTRA_DIRS)); then
            EXTRA_DIRS="{ find $FZFZ_EXTRA_DIRS -type d 2> /dev/null }"
        else
            EXTRA_DIRS="{ true }"
        fi

        FZFZ_SUBDIR_LIMIT=${FZFZ_SUBDIR_LIMIT:=50}

        REMOVE_FIRST="tail -n +2"
        LIMIT_LENGTH="head -n $(($FZFZ_SUBDIR_LIMIT+1))"

        SUBDIRS="{ find $PWD -type d | $LIMIT_LENGTH | $REMOVE_FIRST }"
        RECENTLY_USED_DIRS="{ z -l | tac | sed 's/^[[:digit:].]*[[:space:]]*//' }"

        FZF_COMMAND='fzf --tiebreak=index -m --preview="ls -1 {} | head -$LINES"'

        local COMMAND="{ $SUBDIRS ; $RECENTLY_USED_DIRS ; $EXTRA_DIRS; } | $FZF_COMMAND"

        eval "$COMMAND" | while read item; do
            printf '%q ' "$item"
        done
        echo
    }

    fzfz-file-widget() {
        LBUFFER="${LBUFFER}$(__fzfz)"
        local ret=$?
        zle redisplay
        typeset -f zle-line-init >/dev/null && zle zle-line-init
        return $ret
    }

    zle     -N   fzfz-file-widget
    bindkey '^G' fzfz-file-widget

    # # Ctrl-P - cd to dir or edit file with fzf
    # Put in /usr/local/share/zsh/site-functions/
    # and add to .zshrc
    # source /usr/local/share/zsh/site-functions/ctrl-p
    # inspired by
    # https://adamheins.com/blog/ctrl-p-in-the-terminal-with-fzf
    fzf-edit-file-or-open-dir() {
        local out key file helpline
        helpline="Ctrl-f to reveal in Finder | Enter to edit file"
        # IFS=$'\n' out=($(ag -g "" | fzf --header="$helpline" \
            # IFS=$'\n' out=($(bfs | fzf --header="$helpline" \
            IFS=$'\n' out=($(rg --files --hidden --glob "!.git/*" | fzf --header="$helpline" \
            --exit-0 \
            --expect=ctrl-f \
            --preview '[ -f {} ] && head -n 50 {}' \
            --preview-window down:4 \
            --bind='?:toggle-preview' ))
        key=$(head -1 <<< "$out")
        file=$(head -2 <<< "$out" | tail -1)

        if [ "$key" = ctrl-f ]; then
            open -R "$file" # reveal in Finder
        else
            if [ -f "$file" ]; then
                # /usr/local/bin/mvim "$file"
                /usr/local/bin/mvim "$file"
            elif [ -d "$file" ]; then
                cd "$file"
            fi
            zle reset-prompt
        fi
        zle accept-line
    }
    zle     -N   fzf-edit-file-or-open-dir
    bindkey '^P' fzf-edit-file-or-open-dir
fi
