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
