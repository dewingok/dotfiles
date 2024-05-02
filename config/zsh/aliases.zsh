# sudo - now with aliases!
alias sudo='sudo '

alias g='git'
alias hist='echo "Use <CTRL-R>"'

# Replacement tools
(( $+commands[nvim] )) && alias vim='nvim'
(( $+commands[bat] )) && alias cat="bat" 
(( $+commands[fd] )) && alias find="fd"

# Eza
if (( $+commands[eza] )); then 
  alias ls='eza -a --group-directories-first'
else
  alias ls='ls -a'
  alias ll='ls -l'
fi

# Colorize grep output
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"

alias tokenz="source ~/.bin/aws_session_token"

if (( $+commands[brew] )); then
  alias bup="brew update && brew upgrade"
  alias bug="brew upgrade"
fi

if (( $+commands[apt] )); then
  alias aug="sudo apt upgrade"
  alias aup="sudo apt update && sudo apt upgrade"
fi
