# MAGIC ENTER
# magic enter: if no command is written,
# hitting enter will display some info
function magic_enter {
  local last_err="$?"

  if [ -z "$BUFFER" ] && [ "$CONTEXT" != "cont" ]; then
    local w="\e[0m"
    local rn="\e[0;31m"
    local rb="\e[1;31m"

    local user_host_pwd="$_grey%n$w@$_grey%m$w:$_grey%~$w"
    user_host_pwd="${${(%)user_host_pwd}//\//$w/$_grey}"

    local v_files="$(ls -1 | wc -l)"
    local h_files="$(ls -1A | wc -l)"

    local job_n="$(jobs | wc -l)"

    local timedate="$(date +%R)"

    local iline="[$user_host_pwd] [$timedate] [$_grey$v_files$w ($_grey$h_files$w)]"
    [ "$job_n" -gt 0 ] && iline="$iline [$_grey$job_n$w&]"

    if [ "$last_err" != "0" ]; then
      iline="$iline \e[1;31m[\e[0;31m$last_err\e[1;31m]$w"
    fi

    printf "\n$iline\n"

    # listing
    local output="$(ls -C --color="always" -w $COLUMNS)"

    # git status
    local git_status="$(git -c color.status=always status -s 2> /dev/null)"
    if [ -n "$git_status" ]; then
      output="$output\n$git_status"
    fi

    local output_len="$(echo "$output" | wc -l)"
    if [ -n "$output" ]; then
      if [ "$output_len" -gt "$((LINES - 2))" ]; then
        printf "$output\n" | "$PAGER" -R
      else
        printf "$output\n"
      fi
    fi
    zle redisplay
  else
    zle accept-line
  fi
}

zle -N magic_enter
bindkey "^M" magic_enter

