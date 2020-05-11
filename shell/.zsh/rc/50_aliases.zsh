## Autocorrect nocorrects {{{
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
## }}}

## Aliases {{{
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

    # xdg-open
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
        python -m http.server "$port"
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


## Editor {{{
    # Neovim as $EDITOR
    export EDITOR="nvim"
    if [ -x 'nvim' ]; then
        alias vim=nvim
    fi
## }}}
