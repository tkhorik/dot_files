export TERM=xterm-256color
alias ls='ls --color=auto'
alias grep='grep --color=auto'

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path bash)"
