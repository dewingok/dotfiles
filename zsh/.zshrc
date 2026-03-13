# vim: ft=zsh

### Source aliases and functions ### 
[ -f "$HOME/.config/zsh/aliases.zsh" ]  && source "$HOME/.config/zsh/aliases.zsh"
[ -f "$HOME/.config/zsh/functions.zsh" ]  && source "$HOME/.config/zsh/functions.zsh"

### Shell options and history configuration ###
unsetopt BEEP
setopt AUTO_CD
setopt GLOB_DOTS
setopt NOMATCH
setopt MENU_COMPLETE
setopt EXTENDED_GLOB
setopt INTERACTIVE_COMMENTS
setopt APPEND_HISTORY
HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt BANG_HIST
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

### Prompt and Completions ### 
if (( $+commands[starship] )); then
  eval "$(starship init zsh)"
else
  [ -f "$HOME/.config/zsh/prompt.zsh" ] && source "$HOME/.config/zsh/prompt.zsh"
fi

# Completion system setup
if type brew &> /dev/null; then
  FPATH="$(brew --prefix)/share/zsh-completions:$FPATH"
fi
autoload -Uz compinit
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# zstyle ':completion:*' menu yes select
zstyle ':completion:*' menu no
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zmodload zsh/complist
_comp_options+=(globdots)
compinit -C

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

### Plugins ### 
# List of plugins to load from Homebrew share directory
plugins=(zsh-autosuggestions zsh-syntax-highlighting zsh-vi-mode zsh-system-clipboard fzf-tab)

# Source plugins from Homebrew share directory
HOMEBREW_SHARE="$(brew --prefix)/share"
for plugin in "${plugins[@]}"; do
  [ -f $HOMEBREW_SHARE/$plugin/$plugin.zsh ] && source "$HOMEBREW_SHARE/$plugin/$plugin.zsh"
  [ ! -f $HOMEBREW_SHARE/$plugin/$plugin.zsh ] && echo "Plugin $plugin not found in Homebrew share directory."
done

# Source local plugins or configurations
[ -f "$HOME/.config/zsh/ssh-agent.zsh" ] && source "$HOME/.config/zsh/ssh-agent.zsh"
[ -f "$HOME/.config/zsh/local.zsh" ] && source "$HOME/.config/zsh/local.zsh"

### Integrations ### 
# Zoxide integration
if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
fi

# fzf integration
if (( $+commands[fzf] )); then
  export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS:+${FZF_DEFAULT_OPTS} }--bind=ctrl-y:accept"
  eval "$(fzf --zsh)"
fi
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' switch-group '<' '>'

# Activate mise-managed tool shims for this shell.
if (( $+commands[mise] )); then
  eval "$(mise activate zsh)"
fi

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Google Cloud Completion and PATH setup
if [ -f '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc' ]; then . '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc' ]; then . '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc'; fi
