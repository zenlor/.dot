source ~/.profile

export ZGEN_AUTOLOAD_COMPINIT=0
AUTOPAIR_INHIBIT_INIT=1

_load_repo tarjoilija/zgen $ZGEN_DIR zgen.zsh
if ! zgen saved; then
  echo "Creating zgen save"
  _cache_clear

  zgen load hlissner/zsh-autopair autopair.zsh develop
  zgen load zsh-users/zsh-history-substring-search
  zgen load zdharma/history-search-multi-word
  zgen load zsh-users/zsh-completions src
  zgen load junegunn/fzf shell  # completions

  # colors
  zgen load chrissicool/zsh-256color

  if [[ -z $SSH_CONNECTION ]]; then
    zgen load zdharma/fast-syntax-highlighting
  fi

  zgen save
fi

source $ZDOTDIR/config.zsh
source $ZDOTDIR/completion.zsh
source $ZDOTDIR/keybinds.zsh
source $ZDOTDIR/prompt.zsh
source $ZDOTDIR/magic_enter.zsh
source $ZDOTDIR/git.zsh

#
export _FASD_DATA="$XDG_CACHE_HOME/fasd"
export _FASD_VIMINFO="$XDG_CACHE_HOME/viminfo"
_cache fasd --init posix-alias zsh-{hook,{c,w}comp{,-install}}
autopair-init

# setup completion, and aliases
autoload -Uz compinit && compinit -d $ZSH_CACHE/zcompdump
source $ZDOTDIR/aliases.zsh

# vim:set ft=sh: