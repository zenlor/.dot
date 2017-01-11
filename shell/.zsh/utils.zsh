# Simple Calculator
function = {
  calc="${@//p/+}"
  calc="${calc//x/*}"
  bc -l <<<"scale=10;$calc"
}

# send an alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# nice git revision
function git-rev {
  echo `printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"`
}

# shoreman's .env exporter
function env_file {
  local env_file=${1:-'.env'}

  # Set a default port before loading the .env file
  export PORT=${PORT:-5000}

  if [[ -f "$env_file"  ]]; then
    echo "Exporting .env content"
    export $(grep "^[^#]*=.*" "$env_file" | xargs)
  fi
}

# Add a directory to path
function ipath {
  dir="$1"

  if [ -d $dir ]; then
    export PATH="$PATH:$dir"
  fi
}

# Norris... nuff said
function norris {
  if [ "$1" ]; then
    timeout $1 wget "http://api.icndb.com/jokes/random" -qO- | jshon -e value -e joke -u |
    recode html | cowsay -f tux
  else
    norris 3
  fi
}

# bofh-excuses
function bofh {
  shuf -n 1 $HOME/.zsh/excuses \
    | cowsay -f tux
}

function preview-markdown {
  marked $1 |\
    w3m -T text/html
}
