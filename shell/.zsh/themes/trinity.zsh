# ⟁ Trinity ⟁
# Based on geometry
# geometry: https://github.com/frmendes/geometry

PROMPT_LOCAL="⟁"
PROMPT_SSH="▽"

_prompt() {
    if [[ -n $SSH_CONNECTION ]]; then
        echo $PROMPT_SSH
    else
        echo $PROMPT_LOCAL
    fi
}

PROMPT_OK="%{$fg[green]%}$(_prompt)%{$reset_color%}"
PROMPT_FAIL="%{$fg[red]%}$(_prompt)%{$reset_color%}"

PROMPT_LINE='◈'

GIT_DIRTY="%{$fg[red]%}⬡%{$reset_color%}"
GIT_CLEAN="%{$fg[green]%}⬢%{$reset_color%}"
GIT_REBASE="\uE0A0"
GIT_UNPULLED="⇣"
GIT_UNPUSHED="⇡"

_git_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo "${ref#refs/heads/}"
}

_git_dirty() {
  if test -z "$(git status --porcelain --ignore-submodules)"; then
    echo $GIT_CLEAN
  else
    echo $GIT_DIRTY
  fi
}

_git_rebase_check() {
  git_dir=$(git rev-parse --git-dir)
  if test -d "$git_dir/rebase-merge" -o -d "$git_dir/rebase-apply"; then
    echo " $GIT_REBASE"
  fi
}

_git_remote_check() {
  local_commit=$(git rev-parse @ 2>&1)
  remote_commit=$(git rev-parse @{u} 2>&1)
  common_base=$(git merge-base @ @{u} 2>&1)

  if [[ $local_commit == $remote_commit ]]; then
    echo ""
  else
    if [[ $common_base == $remote_commit ]]; then
      echo " $GIT_UNPUSHED"
    elif [[ $common_base == $local_commit ]]; then
      echo " $GIT_UNPULLED"
    else
      echo " $GIT_UNPUSHED$GIT_UNPULLED"
    fi
  fi
}

_git_symbol() {
  text="$(_git_rebase_check)$(_git_remote_check)"
  if [ ! -z "$text" ]; then
    echo " %F{242}::%{$reset_color%}$text"
  fi
}

_git_info() {
  if git rev-parse --git-dir > /dev/null 2>&1; then
    echo "$(_git_branch)$(_git_symbol) %F{242}::%{$reset_color%} $(_git_dirty)"
  fi
}

_print_title() {}

_set_cmd_title() {
  print -n '\e]0;'
  print -n "$2 @ "
  print -nrD "$PWD"
  print -n '\a'
}

_set_title() {
  print -n '\e]0;'
  print -Pn '%~'
  print -n '\a'
}

trinity_prompt() {
  autoload -U add-zsh-hook

  add-zsh-hook preexec  _set_cmd_title
  add-zsh-hook precmd   _set_title

  PROMPT='%(?.$PROMPT_OK.$PROMPT_FAIL) %{$fg[blue]%}%3~%{$reset_color%} '
  PROMPT2='$PROMPT_LINE '
  RPROMPT='$(_git_info)'
}

trinity_prompt
