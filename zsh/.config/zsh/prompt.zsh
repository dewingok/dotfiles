# A backup shel prompt if starship doesn't work for some reason. It shows the current directory and git branch if applicable.
autoload -U colors zsh/terminfo
colors
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*' formats "%{${fg[blue]}%}(%b) %{${fg[red]}%}%m%u%c%{$reset_color%}"
precmd() {
  vcs_info
}

PROMPT='%{$fg_bold[green]%}%2~ ${vcs_info_msg_0_} ❯ '

setopt prompt_subst
