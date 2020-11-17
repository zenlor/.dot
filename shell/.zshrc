export COMPLETION_WAITING_DOTS="true"

# Correct spelling for commands
setopt correct

# turn off the infernal correctall for filenames
unsetopt correctall

# Base PATH
PATH="$PATH:/usr/local/bin:/usr/local/sbin:/sbin:/usr/sbin:/bin:/usr/bin"

# Conditional PATH additions
for path_candidate in \
    /opt/local/sbin \
    /Applications/Xcode.app/Contents/Developer/usr/bin \
    /opt/local/bin \
    /usr/local/share/npm/bin \
    ~/.cabal/bin \
    ~/.cargo/bin \
    ~/.rbenv/bin \
    ~/bin \
    ~/lib/bin
do
    if [ -d ${path_candidate} ]; then
        export PATH="${PATH}:${path_candidate}"
    fi
done

# Yes, these are a pain to customize. Fortunately, Geoff Greer made an online
# tool that makes it easy to customize your color scheme and keep them in sync
# across Linux and OS X/*BSD at http://geoff.greer.fm/lscolors/
export LSCOLORS='Exfxcxdxbxegedabagacad'
export LS_COLORS='di=1;34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'

if command -v keychain &> /dev/null; then
    eval `keychain --eval --quiet --agents ssh,gpg $SSH_AGENT_KEYS $GPG_AGENT_KEYS`

    cat <<EOF > ~/.ssh/.env
SSH_AUTH_SOCK=$SSH_AUTH_SOCK
SSH_AGENT_PID=$SSH_AGENT_PID
GPG_AGENT_KEYS=$GPG_AGENT_KEYS
GPG_AGENT_INFO=$GPG_AGENT_INFO
EOF
fi

# Now that we have $PATH set up and ssh keys loaded, configure zgen.

# start zgen
if [ -f ~/.config/zsh/plugins ]; then
    source ~/.config/zsh/plugins
fi
# end zgen

# set some history options
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_verify
setopt INC_APPEND_HISTORY
unsetopt HIST_BEEP

# Share your history across all your terminal windows
setopt share_history
#setopt noclobber

# Keep a ton of history. You can reset these without editing .zshrc by
# adding a file to ~/.zshrc.d.
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

# set some options about directories
setopt pushd_ignore_dups
#setopt pushd_silent
setopt AUTO_CD  # If a command is issued that can’t be executed as a normal command,
# and the command is the name of a directory, perform the cd command
# to that directory.

# Add some completions settings
setopt ALWAYS_TO_END     # Move cursor to the end of a completed word.
setopt AUTO_LIST         # Automatically list choices on ambiguous completion.
setopt AUTO_MENU         # Show completion menu on a successive tab press.
setopt AUTO_PARAM_SLASH  # If completed parameter is a directory, add a trailing slash.
setopt COMPLETE_IN_WORD  # Complete from both ends of a word.
unsetopt MENU_COMPLETE   # Do not autoselect the first completion entry.

# Miscellaneous settings
setopt INTERACTIVE_COMMENTS  # Enable comments in interactive shell.

# Long running processes should return time after they complete. Specified
# in seconds.
REPORTTIME=2
TIMEFMT="%U user %S system %P cpu %*Es total"

# Expand aliases inline - see http://blog.patshead.com/2012/11/automatically-expaning-zsh-global-aliases---simplified.html
globalias() {
    if [[ $LBUFFER =~ ' [A-Z0-9]+$' ]]; then
        zle _expand_alias
        zle expand-word
    fi
    zle self-insert
}

zle -N globalias

bindkey " " globalias
bindkey "^ " magic-space           # control-space to bypass completion
bindkey -M isearch " " magic-space # normal space during searches

# Customize to your needs...
# Stuff that works on bash or zsh
if [ -r ~/.sh_aliases ]; then
    source ~/.sh_aliases
fi

# Stuff only tested on zsh, or explicitly zsh-specific
if [ -r ~/.config/zsh/aliases ]; then
    source ~/.config/zsh/aliases
fi

if [ -r ~/.zsh_functions ]; then
    source ~/.zsh_functions
fi

export LOCATE_PATH=/var/db/locate.database

# Load AWS credentials
if [ -f ~/.aws/aws_variables ]; then
    source ~/.aws/aws_variables
fi

# JAVA setup - needed for iam-* tools
if [ -d /Library/Java/Home ];then
    export JAVA_HOME=/Library/Java/Home
fi

if [[ "$(uname -s)" == "Darwin" ]]; then
    # Load macOS-specific aliases
    [ -f ~/.osx_aliases ] && source ~/.osx_aliases
    if [ -d ~/.osx_aliases.d ]; then
        for alias_file in ~/.osx_aliases.d/*
        do
            source "$alias_file"
        done
    fi

  # Apple renamed the OS, so...
  [ -f ~/.macos_aliases ] && source ~/.macos_aliases
  if [ -d ~/.macos_aliases.d ]; then
      for alias_file in ~/.macos_aliases.d/*
      do
          source "$alias_file"
      done
  fi
fi

# deal with screen, if we're using it - courtesy MacOSXHints.com
# Login greeting ------------------
if [ "$TERM" = "screen" -a ! "$SHOWED_SCREEN_MESSAGE" = "true" ]; then
    detached_screens=$(screen -list | grep Detached)
    if [ ! -z "$detached_screens" ]; then
        echo "+---------------------------------------+"
        echo "| Detached screens are available:       |"
        echo "$detached_screens"
        echo "+---------------------------------------+"
    fi
fi

if [ -f /usr/local/etc/grc.bashrc ]; then
    source "$(brew --prefix)/etc/grc.bashrc"

    function ping5(){
        grc --color=auto ping -c 5 "$@"
    }
else
    alias ping5='ping -c 5'
fi

# Speed up autocomplete, force prefix mapping
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)*==34=34}:${(s.:.)LS_COLORS}")';

# Load any custom zsh completions we've installed
if [ -d ~/.config/zsh/completions ]; then
    for completion in ~/.config/zsh/completions/*
    do
        source "$completion"
    done
fi

# Load zmv
if [[ ! -f ~/.config/zsh/no-zmv ]]; then
    autoload -U zmv
fi

# Make it easy to append your own customizations that override the above by
# loading all files from the ~/.config/zsh/rc.d directory
mkdir -p ~/.config/zsh/rc.d
if [ -n "$(/bin/ls ~/.config/zsh/rc.d)" ]; then
    for dotfile in ~/.config/zsh/rc.d/*
    do
        if [ -r "${dotfile}" ]; then
            source "${dotfile}"
        fi
    done
fi

# remove dupes from $PATH using a zsh builtin
# https://til.hashrocket.com/posts/7evpdebn7g-remove-duplicates-in-zsh-path
typeset -aU path;

# If desk is installed, load the Hook for desk activation
[[ -n "$DESK_ENV" ]] && source "$DESK_ENV"


# Fix bracketed paste issue
# Closes #73
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste)

# Load iTerm shell integrations if found.
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

if [[ -z "$DONT_PRINT_SSH_KEY_LIST" ]]; then
    echo
    echo "Current SSH Keys:"
    ssh-add -l
    echo
fi
