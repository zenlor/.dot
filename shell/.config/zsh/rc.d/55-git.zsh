
function git-wt {
    args=("$@")

    case "${args[0]}" in
        l|list)
            git worktree list
            ;;
        -|main)
            main_dir=$(git worktree list | awk 'NR==1 {print $1}')
            if [ -d "${main_dir}" ]; then
                cd $main_dir && exec $SHELL
            fi
            ;;
        *)
            directory=$(git worktree list | awk '/'"${args[0]}"'/ {print $1}' | awk 'NR==1 {print $1}')
            if [ -d "$directory" ]; then
                cd $directory && exec $SHELL
            else
            fi
            ;;
    esac
}

