local g_pull() {
  if [ $# -eq 2 ]; then
    git pull --rebase -q $2 "$(git rev-parse --abbrev-ref HEAD)"
  else
    git pull --rebase -q origin "$(git rev-parse --abbrev-ref HEAD)"
  fi
}

local g_push() {
  if [ $# -eq 2 ]; then
    git push -q $2 "$(git rev-parse --abbrev-ref HEAD)"
  else
    git push -q origin "$(git rev-parse --abbrev-ref HEAD)"
  fi
}

local g_send() {
  git add "$(git rev-parse --show-toplevel)"
  if [ $# -eq 1 ]; then
    git commit -a -m "$1"
  else
    git commit -a -m "I'm too lazy to write a commit message."
  fi
  g_pull
  g_push
}

g() {
  case $1 in
    "send"|"s")
      g_send
      ;;
    "push"|"u")
      g_push
      ;;
    "pull"|"p")
      g_pull
      ;;
    *)
      echo "g <command>"
      echo "  send|s            adds everything, commits, pushes"
      echo "  push|p [remote]   push current branch to [remote] or origin"
      echo "  pull|u [remote]   pull current branch from [remote] or origin"
  esac
}
