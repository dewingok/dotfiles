SHELL := /bin/zsh
UNAME := $(shell uname -s)
USER  := $(shell whoami)

main: install

.PHONY: main install setup dev test lint plugin-managers brew-bundle mise-install zap tpm dirs stow stow-delete check

install: setup

setup: dirs brew-bundle stow plugin-managers mise-install check

dev:
	@echo "Dotfiles repo has no dev runtime target. Use 'make setup' for bootstrap."

test:
	@echo "No automated tests configured for dotfiles yet."

lint:
	@echo "No lint target configured for dotfiles yet."

plugin-managers: zap tpm

brew-bundle:
	@if command -v brew >/dev/null 2>&1; then \
		brew bundle --file=./Brewfile; \
	else \
		echo "Homebrew not found. Install Homebrew first: https://brew.sh"; \
		exit 1; \
	fi

mise-install:
	@if command -v mise >/dev/null 2>&1; then \
		mise install; \
	else \
		echo "mise not found yet; skipping 'mise install'."; \
	fi

check:
	@echo "Running post-bootstrap checks..."
	@command -v stow >/dev/null 2>&1 || (echo "Missing required command: stow" && exit 1)
	@command -v tmux >/dev/null 2>&1 || (echo "Missing required command: tmux" && exit 1)
	@command -v nvim >/dev/null 2>&1 || (echo "Missing required command: nvim" && exit 1)
	@command -v mise >/dev/null 2>&1 || (echo "Missing required command: mise" && exit 1)
	@mise which uv >/dev/null 2>&1 || (echo "Missing required mise tool: uv" && exit 1)
	@mise which pnpm >/dev/null 2>&1 || (echo "Missing required mise tool: pnpm" && exit 1)
	@mise exec -- uv --version >/dev/null 2>&1 || (echo "Unable to run uv via mise" && exit 1)
	@mise exec -- pnpm --version >/dev/null 2>&1 || (echo "Unable to run pnpm via mise" && exit 1)
	@echo "Bootstrap checks passed."

zap:
	zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1 --keep

tpm:
	@if [ -d ~/.config/tmux/plugins/tpm/.git ]; then \
		echo "TPM already installed; skipping clone."; \
	else \
		git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm; \
	fi

dirs:
	mkdir -p ~/.ssh && chmod 0700 ~/.ssh
	mkdir -p ~/.config/{git,tmux,zsh}

stow: dirs
	stow */ -vt ~ 

stow-delete:
	stow -D */ -vt ~
