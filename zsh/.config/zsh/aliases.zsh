# sudo - now with aliases!
alias sudo='sudo '

# Additive shortcuts for modern tools
(( $+commands[bat] )) && alias b='bat'
(( $+commands[fd] )) && alias f='fd'
(( $+commands[fd] )) && alias ff='fd -H'
(( $+commands[eza] )) && alias l='eza -a --group-directories-first'
(( $+commands[eza] )) && alias ll='eza -la --group-directories-first'
(( $+commands[rg] )) && alias r='rg'

alias g='git'
alias hist='echo "Use <CTRL-R>"'

alias freshsesh="source ~/.bin/aws-session-token"

if (( $+commands[brew] )); then
  alias bup="brew update && brew upgrade"
  alias bug="brew upgrade"
fi

if (( $+commands[apt] )); then
  alias aug="sudo apt upgrade"
  alias aup="sudo apt update && sudo apt upgrade"
fi
