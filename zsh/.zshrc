# vim: ft=zsh
# Load Zap
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

# Plugins
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-syntax-highlighting"

# Source configs with Zap
plug "$HOME/.config/zsh/functions.zsh"
plug "$HOME/.config/zsh/aliases.zsh"
plug "$HOME/.config/zsh/prompt.zsh"
plug "$HOME/.config/zsh/ssh-agent.zsh"
[ -f "$HOME/.config/zsh/local.zsh" ] && plug "$HOME/.config/zsh/local.zsh"

# Load and initialise completion system
autoload -Uz compinit
compinit

# Load zmv
autoload -U zmv

# Use Emacs style bindings
bindkey -e
bindkey '[C' forward-word
bindkey '[D' backward-word

# History options
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
HISTORY_IGNORE="(*KEY*:*SECRET*:*PASSWORD*)" 
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS

# Exports
export EDITOR=$(which vim)

# fzf integration
if (( $+commands[fzf] )); then
  eval "$(fzf --zsh)"
fi

# Go
if (( $+commands[go] )); then
  export GOPATH="$HOME/go"
  export PATH="$PATH:$GOPATH/bin"
fi

# Python virtualenvwrapper
# VIRTUALENVWRAPPER_PYTHON="$(command \which python3)"
# source /usr/local/bin/virtualenvwrapper.sh
