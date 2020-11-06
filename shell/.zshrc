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
[ -z "$TMUX"  ] && [ -v "$SSH_CLIENT" ] && { tmux attach || exec tmux new-session && exit }

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
    zinit light "Tarrasch/zsh-autoenv"

    # FZF
    zinit ice from"gh-r" as"program"
    zinit load "junegunn/fzf-bin"
    zinit load "unixorn/fzf-zsh-plugin"

    zinit light Aloxaf/fzf-tab


    # git-extras
    zinit ice as"program" pick"$ZPFX/bin/git-*" make"PREFIX=$ZPFX"
    zinit light tj/git-extras
    zinit light unixorn/git-extra-commands
    zinit light ytakahashi/igit

    # rupa/z
    zinit load agkozak/zsh-z
    #zinit load "skywind3000/z.lua"

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

#
# Environment settings
#

###
### Defaults
###

# Completion {{{
    fpath+="$HOME/.zsh/completions"

    autoload -Uz compinit && compinit
    zinit cdreplay -q
# }}}

# IN-Sane defaults {{{
    # no c-s/c-q output freezing
    setopt noflowcontrol
    # allow expansion in prompts
    setopt prompt_subst
    # display PID when suspending processes as well
    setopt longlistjobs
    # try to avoid the 'zsh: no matches found...'
    setopt nonomatch
    # report the status of backgrounds jobs immediately
    setopt notify
    # whenever a command completion is attempted, make sure the entire command path
    # is hashed first.
    setopt hash_list_all
    # not just at the end
    setopt completeinword
    # use zsh style word splitting
    setopt noshwordsplit
    # allow use of comments in interactive code
    setopt interactivecomments
    # automatically cd on plain folder names
    setopt autocd

    ## More insanity
    #
    # in order to use #, ~ and ^ for filename generation grep word
    # *~(*.gz|*.bz|*.bz2|*.zip|*.Z) -> searches for word not in compressed files
    # don't forget to quote '^', '~' and '#'!
    setopt extended_glob

    # don't error out when unset parameters are used
    setopt unset

    # completion menu
    zstyle ':completion:*' menu select

    # Case insensitive completion
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
# }}}

## History {{{
    # History file configuration
    [ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
    HISTSIZE=50000
    SAVEHIST=10000
    # record timestamp of command in HISTFILE
    setopt extended_history
    # delete duplicates first when HISTFILE size exceeds HISTSIZE
    setopt hist_expire_dups_first
    # ignore duplicated commands history list
    setopt hist_ignore_dups
    # ignore ALL duplicates
    setopt hist_ignore_all_dups
    # ignore commands that start with space
    setopt hist_ignore_space
    # show command with history expansion to user before running it
    setopt hist_verify
    # add commands to HISTFILE in order of execution
    setopt inc_append_history
    # share command history data
    setopt share_history
# }}}

## Up/Down history search with context {{{
    autoload -Uz up-line-or-beginning-search down-line-or-beginning-search

    zle -N up-line-or-beginning-search
    zle -N down-line-or-beginning-search

    bindkey '^[[A'  up-line-or-beginning-search    # Arrow up
    bindkey '^[OA'  up-line-or-beginning-search
    bindkey '^[[B'  down-line-or-beginning-search  # Arrow down
    bindkey '^[OB'  down-line-or-beginning-search#
#}}}

###
### Vi-mode
### {{{
    bindkey -v

    # Don't take 0.4s to change modes
    export KEYTIMEOUT=1

    # Default color settings
    if [ -z "$VIMTO_COLOR_NORMAL_TEXT" ]; then VIMTO_COLOR_NORMAL_TEXT=black; fi
    if [ -z "$VIMTO_COLOR_NORMAL_BACKGROUND" ]; then VIMTO_COLOR_NORMAL_BACKGROUND=white; fi

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
    # homebrew gettex
    export PATH="/usr/local/opt/gettext/bin:$PATH"
#}}}

###
### Aliases
### {{{
    # Autocorrect nocorrects
    alias cp='nocorrect cp'
    alias ebuild='nocorrect ebuild'
    alias gist='nocorrect gist'
    alias heroku='nocorrect heroku'
    alias hpodder='nocorrect hpodder'
    alias man='nocorrect man'
    alias mkdir='nocorrect mkdir'
    alias mv='nocorrect mv'
    alias mysql='nocorrect mysql'
    alias sudo='nocorrect sudo'
    alias make='nocorrect make'

    setopt correct_all
    # }}}

    # Enable color support
    ls --color -d . &> /dev/null && alias ls='ls --color=auto' || alias ls='ls -G'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'

    # Some more basic aliases
    #
    command -v exa &>/dev/null && alias ls=exa || true
    alias sl=ls
    alias l=ls
    alias ll='ls -lh'
    alias la='ls -la'

    # Git
    alias git='noglob git'

    # xdg-open if exists
    command -v xdg-open &>/dev/null && alias open='xdg-open' || true

    # bc with mathlib (cause I like floats)
    alias bc='bc -l'

    # emacs client
    #   no wait
    alias ec='emacsclient -n'
    #   create new frame
    alias ecc='emacsclient -n -c'

    # Simple HTTP server
    function server() {
        local port="${1:-8000}"
        open "http://localhost:${port}/"
        python -m SimpleHTTPServer "${port}"
    }
    alias server=server

    # ipaddresses
    function ipaddresses() {
        ip addr | awk '/[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\./ {sub(/addr:/,""); print $2 }'
    }
    alias ipaddresses=ipaddresses

    # Pacman
    command -v pacman &>/dev/null && alias pac=yay

    # htop
    alias htopu="htop -u $USER"

    # neovim
    if command -v nvim &> /dev/null; then
        alias vim=nvim
    fi
    # }}}

    # Editor {{{
    # Neovim as $EDITOR
    export EDITOR="nvim"
    if [ -x 'nvim' ]; then
        alias vim=nvim
    fi
    #}}}
###}}}

###
### pipenv
###
#{{{
# Environment file for all projects.
#  - (de)activates Python virtualenvs (.venv) from pipenv
    if [[ $autoenv_event == 'enter' ]]; then
    autoenv_source_parent

    _my_autoenv_venv_chpwd() {
        if [[ -z "$_ZSH_ACTIVATED_VIRTUALENV" && -n "$VIRTUAL_ENV" ]]; then
        return
        fi

        setopt localoptions extendedglob
        local -a venv
        venv='(./(../)#.venv(NY1:A))'

        if [[ -n "$_ZSH_ACTIVATED_VIRTUALENV" && -n "$VIRTUAL_ENV" ]]; then
        if ! (( $#venv )) || [[ "$_ZSH_ACTIVATED_VIRTUALENV" != "$venv[1]" ]]; then
            unset _ZSH_ACTIVATED_VIRTUALENV
            echo "De-activating virtualenv: ${(D)VIRTUAL_ENV}" >&2

            # Simulate "deactivate", but handle $PATH better (remove VIRTUAL_ENV).
            if ! autoenv_remove_path $VIRTUAL_ENV/bin; then
            echo "warning: ${VIRTUAL_ENV}/bin not found in \$PATH" >&2
            fi

            # NOTE: does not handle PYTHONHOME/_OLD_VIRTUAL_PYTHONHOME
            unset _OLD_VIRTUAL_PYTHONHOME
            # NOTE: does not handle PS1/_OLD_VIRTUAL_PS1
            unset _OLD_VIRTUAL_PS1
            unset VIRTUAL_ENV
        fi
        fi

        if [[ -z "$VIRTUAL_ENV" ]]; then
        if (( $#venv )); then
            echo "Activating virtualenv: ${(D)venv}" >&2
            export VIRTUAL_ENV=$venv[1]
            autoenv_prepend_path $VIRTUAL_ENV/bin
            _ZSH_ACTIVATED_VIRTUALENV="$venv[1]"
        fi
        fi
    }
    autoload -U add-zsh-hook
    add-zsh-hook chpwd _my_autoenv_venv_chpwd
    _my_autoenv_venv_chpwd
    else
    add-zsh-hook -d chpwd _my_autoenv_venv_chpwd
    fi
#}}}

###
### OSX
###{{{
if [ -d "/usr/local/opt/cython/bin"  ]; then
        export PATH="/usr/local/opt/cython/bin:/usr/local/opt/sphinx-doc/bin:$PATH"
fi

if [ -d "/usr/local/opt/qt/bin"  ]; then
    export PATH="/usr/local/opt/qt/bin:$PATH"
    #export LDFLAGS="-L/usr/local/opt/qt/lib"
    #export CPPFLAGS="-I/usr/local/opt/qt/include"
    #export PKG_CONFIG_PATH="/usr/local/opt/qt/lib/pkgconfig"
fi
if [ -d "$HOME/Library/Python/3.8/bin"  ]; then
    export PATH="/Users/lgiuliani/Library/Python/3.8/bin:$PATH"
fi
# osx path support
[ -x "/usr/libexec/path_helper" ] &&\
    eval `/usr/libexec/path_helper -s`\
    || true
###}}}

# local environment
[ -f "$HOME/.zshrc.local" ] && source ~/.zshrc.local || true

# fzf
if [ -f "$HOME/.fzf.zsh" ]; then
    source $HOME/.fzf.zsh
    enable-fzf-tab
fi

# ghq
command -v ghq &>/dev/null && export GHQ_ROOT="${HOME}/lib/src" || true
