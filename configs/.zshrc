# .zshrc
 
# Emacs binds (for the time being).
bindkey -e

# Navigation
bindkey '[C' forward-word
bindkey '[D' backward-word

# History options.
HISTFILE=~/.histfile
HISTSIZE=3000
SAVEHIST=3000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt BRACE_CCL

# zsh completion options.
zstyle ':completion:*' completer _expand _complete _ignored
zstyle :compinstall filename '/Users/ndewing/.zshrc'

# Enable completion
autoload -Uz compinit
compinit

# OS variables
[[ "$(uname -s)" = "Darwin" ]] && export MACOS=1 && export UNIX=1
[[ "$(uname -s)" = "Linux" ]] && export LINUX=1 && export UNIX=1

# Sourcing other files.
source $HOME/.zsh/aliases
source $HOME/.zsh/prompt
source $HOME/.zsh/functions

# Base16 Shell
BASE16_SHELL=$HOME/github/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

export PATH="$HOME/bin:/usr/local/sbin:/usr/local/bin:$PATH"
[[ $LINUX ]] && export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="$(go env GOPATH)/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/lib/ruby/gems/2.6.0/bin:$PATH"
export EDITOR=$(which vim)

# Python virtualenvwrapper
# VIRTUALENVWRAPPER_PYTHON="$(command \which python3)"
# source /usr/local/bin/virtualenvwrapper.sh
