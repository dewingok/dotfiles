# sudo - now with aliases!
alias sudo='sudo '

# Replacement tools
(( $+commands[nvim] )) && alias vim='nvim'
(( $+commands[bat] )) && alias cat="bat" 
(( $+commands[fd] )) && alias find="fd"
(( $+commands[eza] )) && alias ls='eza -a --group-directories-first'

alias ll='ls -l'
alias g='git'
alias hist='echo "Use <CTRL-R>"'

# Colorize grep output
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"

alias freshsesh="source ~/.bin/aws-session-token"

if (( $+commands[brew] )); then
  alias bup="brew update && brew upgrade"
  alias bug="brew upgrade"
fi

if (( $+commands[apt] )); then
  alias aug="sudo apt upgrade"
  alias aup="sudo apt update && sudo apt upgrade"
fi
