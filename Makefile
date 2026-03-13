SHELL := /bin/zsh
.DEFAULT_GOAL := setup
XDG_CONFIG_HOME ?= $(HOME)/.config
TPM_DIR := $(XDG_CONFIG_HOME)/tmux/plugins/tpm
STOW_PACKAGES := $(patsubst %/,%,$(wildcard */))

.PHONY: install setup dev test lint plugin-managers brew-bundle mise-install zap tpm dirs stow stow-delete check

install: setup

setup: dirs brew-bundle stow tpm mise-install check

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
	@for cmd in stow tmux nvim mise; do \
		command -v $$cmd >/dev/null 2>&1 || { echo "Missing required command: $$cmd"; exit 1; }; \
	done
	@for tool in uv pnpm; do \
		mise which $$tool >/dev/null 2>&1 || { echo "Missing required mise tool: $$tool"; exit 1; }; \
		mise exec -- $$tool --version >/dev/null 2>&1 || { echo "Unable to run $$tool via mise"; exit 1; }; \
	done
	@echo "Bootstrap checks passed."

tpm:
	@if [ -d "$(TPM_DIR)/.git" ]; then \
		echo "TPM already installed; skipping clone."; \
	else \
		git clone https://github.com/tmux-plugins/tpm "$(TPM_DIR)"; \
	fi

dirs:
	@if [ ! -d ~/.ssh ]; then \
		mkdir -p ~/.ssh; \
		chmod 0700 ~/.ssh; \
	else \
		echo "~/.ssh already exists; skipping."; \
	fi
	@for dir in "$(XDG_CONFIG_HOME)/git" "$(XDG_CONFIG_HOME)/tmux" "$(XDG_CONFIG_HOME)/zsh" "$(HOME)/.local/bin"; do \
		if [ ! -d $$dir ]; then \
			mkdir -p "$$dir"; \
		else \
			echo "$$dir already exists; skipping."; \
		fi; \
	done

stow: dirs
	stow $(STOW_PACKAGES) -vt ~

stow-delete:
	stow -D $(STOW_PACKAGES) -vt ~
