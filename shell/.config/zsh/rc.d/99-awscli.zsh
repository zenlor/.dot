if command -v aws_completer &> /dev/null; then

    complete -C "$(which aws_completer)" aws
fi
