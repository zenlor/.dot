# zplug {{{
    # Check if zgen is installed
    if [[ ! -d "${ZPLUG_HOME}" ]]; then
        git clone https://github.com/zplug/zplug.git "${ZPLUG_HOME}"
    fi

    # load zgen
    source "${ZPLUG_HOME}/init.zsh"

    # vim things
    zplug "laurenkt/zsh-vimto"

    # completions
    zplug "zsh-users/zsh-completions"

    # autoenv
    zplug "Tarrasch/zsh-autoenv"

    # z
    zplug "rupa/z", use:"*.sh"

    # colorful colors
    zplug "chrissicool/zsh-256color"

    # colorful command lines
    zplug "zdharma/fast-syntax-highlighting"

    # theme
    zplug "eendroroy/alien-minimal"

    # forget me not
    zplug "larkery/zsh-histdb"

    # Deer
    zplug "vifon/deer", use:deer

    # Install plugins if there are plugins that have not been installed
    if ! zplug check --verbose; then
        zplug install
    fi

    # Then, source plugins and add commands to $PATH
    zplug load
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

# Autocorrect {{{
    # taken from oh-my-zsh
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

### VIm Mode
bindkey -v
KEYTIMEOUT=1

#
# Prompt
#
export PROMPT_SFZ_CHAR="λ"

#
# Colors
#
[ -f "$HOME/.cache/vim/bundle/gruvbox/gruvbox_256palette.sh" ]\
    && source "$HOME/.cache/vim/bundle/gruvbox/gruvbox_256palette.sh"
#
# Environment settings
#

# Neovim as $EDITOR
export EDITOR="nvim"
if [ -x 'nvim' ]; then
    alias vim=nvim
fi

# Deer {{{
    # enable deer
    zle -N deer
    # C-k
    bindkey '\ek' deer
    # height
    zstyle ':deer:' height 35
# }}}

# Enable keychain
if command -v keychain &> /dev/null; then
    eval `keychain --eval --quiet --agents ssh $SSH_AGENT_KEYS`
fi

## Aliases {{{
    # Enable color support
    ls --color -d . &> /dev/null && alias ls='ls --color=auto' || alias ls='ls -G'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'

    # Some more basic aliases
    alias sl=ls
    alias ll='ls -lh'
    alias la='ls -lAh'
    alias l='ls -lah'

    # Git
    alias git='noglob git'

    # xdg-open
    command -v xdg-open &>/dev/null && alias open='xdg-open' || true

    # emacs client
    #   no wait
    alias ec='emacsclient -n'
    #   create new frame
    alias ecc='emacsclient -n -c'

    # Simple HTTP server
    function server() {
        local port="${1:-8000}"
        open "http://localhost:${port}/"
        python -m http.server "$port"
    }
    alias server=server

    # ipaddresses
    function ipaddresses() {
        ip addr | awk '/[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\./ {sub(/addr:/,""); print $2 }'
    }
    alias ipaddresses=ipaddresses

    # Pacman
    alias pac=yay

    # htop
    alias htopu="htop -u $USER"

    # neovim
    if command -v nvim &> /dev/null; then
        alias vim=nvim
    fi
# }}}

# homebrew gettex
export PATH="/usr/local/opt/gettext/bin:$PATH"

# osx support
[ -x "/usr/libexec/path_helper" ] && eval `/usr/libexec/path_helper -s` || true

# local environment
[ -f "$HOME/.zshrc.local" ] && source ~/.zshrc.local

### END
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
