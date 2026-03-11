# vim: ft=zsh
# Load Zap
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

typeset -g ZSH_DOTFILES_DIR=${${(%):-%N}:A:h}

# Plugins
# plug "zsh-users/zsh-autosuggestions"
plug "marlonrichert/zsh-autocomplete"
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-syntax-highlighting"

# Source configs with Zap
plug "$HOME/.config/zsh/functions.zsh"
plug "$HOME/.config/zsh/aliases.zsh"
plug "$HOME/.config/zsh/prompt.zsh"
plug "$HOME/.config/zsh/ssh-agent.zsh"
[ -f "$HOME/.config/zsh/keybindings.zsh" ] && ZSH_KEYBINDINGS_FILE="$HOME/.config/zsh/keybindings.zsh"
[ -z "$ZSH_KEYBINDINGS_FILE" ] && [ -f "$ZSH_DOTFILES_DIR/.config/zsh/keybindings.zsh" ] && ZSH_KEYBINDINGS_FILE="$ZSH_DOTFILES_DIR/.config/zsh/keybindings.zsh"
[ -f "$HOME/.config/zsh/local.zsh" ] && plug "$HOME/.config/zsh/local.zsh"

# Load and initialise completion system
# fpath+=~/.zfunc
# autoload -Uz compinit
# compinit

# Load zmv
autoload -U zmv

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
if (( $+commands[nvim] )); then
  export EDITOR=$(which nvim)
else
  export EDITOR=$(which vim)
fi

# Activate mise-managed tool shims for this shell.
if (( $+commands[mise] )); then
  eval "$(mise activate zsh)"
fi

# fzf integration
if (( $+commands[fzf] )); then
  export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS:+${FZF_DEFAULT_OPTS} }--bind=ctrl-y:accept"
  eval "$(fzf --zsh)"
fi

[ -n "$ZSH_KEYBINDINGS_FILE" ] && source "$ZSH_KEYBINDINGS_FILE"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc' ]; then . '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc' ]; then . '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc'; fi
