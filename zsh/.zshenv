# zshenv is sourced on all invocations of the shell, so it should only contain things that need to be set for every shell, such as PATH and environment variables.

# exports
export ZSHRC="${ZDOTDIR:-$HOME}/.zshrc"
export PATH="$HOME/.local/bin:$PATH"
export EDITOR=$(which nvim 2>/dev/null || which vim 2>/dev/null)
