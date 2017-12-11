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
fi
