# fzf
#
if [ -x "$(which fzf)" ]; then
  #
  # Key Bindings
  #
  source "/usr/share/fzf/key-bindings.zsh"
  #
  # Completion
  #
  source "/usr/share/fzf/completion.zsh"

  #
  # Default options
  #
  export FZF_DEFAULT_OPTS='
  --color fg:-1,bg:-1,hl:230,fg+:3,bg+:233,hl+:229
  --color info:150,prompt:110,spinner:150,pointer:167,marker:174
  '
fi