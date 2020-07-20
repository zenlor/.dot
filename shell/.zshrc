if [[ "$TERM" == "dumb" ]]; then
        unsetopt zle
        unsetopt prompt_cr
        unsetopt prompt_subst
        if whence -w precmd >/dev/null; then
                unfunction precmd
        fi
        if whence -w preexec >/dev/null; then
                unfunction preexec
        fi
        PS1='$ '
        return
fi

# tmux
[ -z "$TMUX"  ] && { tmux attach || exec tmux new-session && exit }

# zinit {{{
    declare -A ZINIT
    ZINIT[HOME_DIR]="$HOME/.cache/zinit"

    # Check if zinit is installed
    if [[ ! -d "${ZINIT[HOME_DIR]}" ]]; then
        git clone https://github.com/zdharma/zinit.git "${ZINIT[HOME_DIR]}/bin"
    fi

    # load zinit
    source "${ZINIT[HOME_DIR]}/bin/zinit.zsh"

    # completions
    zinit load "zsh-users/zsh-completions"

    # colorful command lines
    zinit light "zdharma/fast-syntax-highlighting"

    # autoenv
    #zinit light "Tarrasch/zsh-autoenv"

    # FZF
    zinit ice from"gh-r" as"program"
    zinit load "junegunn/fzf-bin"

    zinit ice as"completion"
    zinit snippet https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh
    zinit snippet https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh

    # git-extras
    zinit ice as"program" pick"$ZPFX/bin/git-*" make"PREFIX=$ZPFX"
    zinit light tj/git-extras

    # rupa/z
    zinit load agkozak/zsh-z

    # Tarrasch/zsh-autoenv
    zinit light "Tarrasch/zsh-autoenv"

    #
    ## THEME
    #
    # colorful colors
    zinit light "chrissicool/zsh-256color"

    # geometry theme
    zinit light "geometry-zsh/geometry"
# }}}

#
# Environment settings
#

# Zsh scripts {{{
for i in $HOME/.zsh/rc/*.zsh; do
    . $i
done
# }}}

# homebrew gettex
export PATH="/usr/local/opt/gettext/bin:$PATH"

# osx support
[ -x "/usr/libexec/path_helper" ] &&\
    eval `/usr/libexec/path_helper -s`\
    || true

# local environment
[ -f "$HOME/.zshrc.local" ] && source ~/.zshrc.local || true

# ghq
command -v ghq &>/dev/null && export GHQ_ROOT="${HOME}/lib/src" || true

# fzf
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh || true

### END
