# Use emacs key bindings
bindkey -e

zmodload zsh/terminfo
#
# [Ctrl-r] - Search backward incrementally for a specified string.
# The string may begin with ^ to anchor the search to the beginning of the line.
bindkey '^r' history-incremental-search-backward

# [PageUp] - Up a line of history
bindkey "$terminfo[kpp]" up-line-or-history

# [PageDown] - Down a line of history
bindkey "$terminfo[knp]" down-line-or-history

# start typing + [Up|Down-Arrow] - fuzzy find history
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# [Home] - Go to beginning of line
bindkey "$terminfo[khome]" beginning-of-line

# OPTION+left
bindkey '[D' beginning-of-line

# [End] - Go to end of line
bindkey "$terminfo[kend]"  end-of-line

# OPTION+right
bindkey '[C' end-of-line

# [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5C' forward-word

# [Ctrl-LeftArrow] - move backward one word
bindkey '^[[1;5D' backward-word

# [Shift-Tab] - move through the completion menu backwards
bindkey "$terminfo[kcbt]" reverse-menu-complete

# [Backspace] - delete backward
bindkey '^?' backward-delete-char

# [Delete] - delete forward
if [[ ! -z "$terminfo[kdch1]" ]]; then
	bindkey "$terminfo[kdch1]" delete-char
else
	bindkey "^[[3~" delete-char
	bindkey "^[3;5~" delete-char
	bindkey "\e[3~" delete-char
fi

# remove / from Word content
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
