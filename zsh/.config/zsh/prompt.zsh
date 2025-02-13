# Prompt customizations
if (( $+commands[starship] )); then
  eval "$(starship init zsh)"
else
  # If Starship isn't available, a prompt using native ZSH modules
  autoload -U colors zsh/terminfo
  colors
  autoload -Uz vcs_info
  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:*' check-for-changes true
  zstyle ':vcs_info:git*' formats "%{${fg[cyan]}%}[%{${fg[blue]}%}%b%{$fg[cyan]%}][%{${fg[yellow]}%}%m%u%c%{${fg[cyan]}%}]%{$reset_color%}"
  precmd() {
    vcs_info
  }
  PS1='${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[blue]%}%c%{$reset_color%}${vcs_info_msg_0_} %# '
  setopt prompt_subst
fi
