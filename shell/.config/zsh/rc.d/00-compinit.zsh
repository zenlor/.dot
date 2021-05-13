#!/usr/bin/env zsh
# Speeds up load time
DISABLE_UPDATE_PROMPT=true

# Perform compinit only once a day.
autoload -Uz compinit

setopt EXTENDEDGLOB
for dump in $ZSH_COMPDUMP(#qN.m1); do
    compinit
    if [[ -s "$dump" && (! -s "$dump.zwc" || "$dump" -nt "$dump.zwc")  ]]; then
        zcompile "$dump"
    fi
    echo "Initializing Completions..."
done
unsetopt EXTENDEDGLOB
compinit -C
