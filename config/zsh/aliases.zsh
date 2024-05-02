# sudo - now with aliases!
alias sudo='sudo '

alias g='git'
alias hist='echo "Use <CTRL-R>"'

# Replacement tools
[ eval $(command_exists nvim) ] && alias vim='nvim'
[ eval $(command_exists bat) ] && alias cat="bat" 
[ eval $(command_exists fd) ] && alias find="fd"

# Eza
if [ eval $(command_exists eza) ]; then 
  alias ls='eza -a --group-directories-first'
  alias ll='ls -l'
fi

# Colorize grep output
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"

alias tokenz="source ~/.bin/aws_session_token"

if command_exists brew; then
  alias bup="brew update && brew upgrade"
  alias bug="brew upgrade"
fi

if command_exists apt; then
  alias aug="sudo apt upgrade"
  alias aup="sudo apt update && sudo apt upgrade"
fi
