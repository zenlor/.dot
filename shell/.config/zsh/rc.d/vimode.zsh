bindkey -v

# Don't take 0.4s to change modes
export KEYTIMEOUT=1

function zle-keymap-select zle-line-init {
# If it's not tmux then can use normal sequences
if [[ -z "${TMUX}" ]]; then
    local vicmd_seq="\e[2 q"
    local viins_seq="\e[0 q"
else
    # In tmux, escape sequences to pass to terminal need to be
    # surrounded in a DSC sequence and double-escaped:
    # ESC P tmux; {text} ESC \
    # <http://linsam.homelinux.com/tmux/tmuxcodes.pdf>
    local vicmd_seq="\ePtmux;\e\e[2 q\e\\"
    local viins_seq="\ePtmux;\e\e[0 q\e\\"
fi
}

# Fix backspace not working after returning from cmd mode
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char

# Re-enable incremental search from emacs mode (it's useful)
bindkey '^r' history-incremental-search-backward
