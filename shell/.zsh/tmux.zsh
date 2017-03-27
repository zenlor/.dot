
# Start tmux at start
if [ -z "$Z_TMUX" ]; then
  test -z "$TMUX" && (tmux attach || tmux new-session)
fi
