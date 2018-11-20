# zgen {{{
    # Check if zgen is installed
    if [[ ! -d "${ZGEN_DIR}" ]]; then
        git clone https://github.com/tarjoilija/zgen.git "${ZGEN_DIR}"
    fi

    # load zgen
    source "${ZGEN_DIR}/zgen.zsh"

    # if the init scipt doesn't exist
    if ! zgen saved; then

        # vim things
        zgen load laurenkt/zsh-vimto

        # completions
        zgen load zsh-users/zsh-completions src

        # autoenv
        zgen load Tarrasch/zsh-autoenv

        # z
        zgen load rupa/z

        # colorful colors
        zgen load chrissicool/zsh-256color

        # colorful command lines
        zgen load zdharma/fast-syntax-highlighting

        # theme
        zgen load mreinhardt/sfz-prompt.zsh

        # save all to init script
        zgen save
    fi
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

    ## More insanity
    #
    # in order to use #, ~ and ^ for filename generation grep word
    # *~(*.gz|*.bz|*.bz2|*.zip|*.Z) -> searches for word not in compressed files
    # don't forget to quote '^', '~' and '#'!
    setopt extended_glob

    # don't error out when unset parameters are used
    setopt unset
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
    # ignore commands that start with space
    setopt hist_ignore_space
    # show command with history expansion to user before running it
    setopt hist_verify
    # add commands to HISTFILE in order of execution
    setopt inc_append_history
    # share command history data
    setopt share_history
# }}}

### VIm Mode
bindkey -v
KEYTIMEOUT=1

#
# Prompt
#
export PROMPT_SFZ_CHAR="λ"

#
# Environment settings
#

# Enable keychain
if command -v keychain &> /dev/null; then
    eval `keychain --eval --quiet --agents ssh id_rsa id_frenzart.com`
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

### END
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
