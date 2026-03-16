# zsh_copy_bindkey() {
#   local keymap=$1
#   local source_key=$2
#   local target_key=$3
#   local binding
#   local widget
#
#   binding=$(bindkey -M "$keymap" "$source_key" 2>/dev/null) || return 0
#   [[ $binding == *' undefined-key' ]] && return 0
#
#   widget=${binding##* }
#   [[ -n $widget ]] || return 0
#
#   bindkey -M "$keymap" "$target_key" "$widget"
# }
#
# zsh_copy_bindkey emacs '^[[C' '^Y'
# zsh_copy_bindkey viins '^[[C' '^Y'
# zsh_copy_bindkey menuselect '^M' '^Y'

bindkey '^y' autosuggest-accept
