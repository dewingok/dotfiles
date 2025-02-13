SHELL := /bin/zsh
UNAME := $(shell uname -s)
USER  := $(shell whoami)

ifeq ($(UNAME), Darwin)
	OS := macos
else ifeq ($(UNAME), Linux)
	OS := linux
endif

main: $(OS) brew-install brew-packages plugin-managers stow

linux:
	sudo -v
	command -v apt && sudo apt install $(cat mint.list)

macos: 

brew-install:
	sudo -v
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

brew-packages:
	brew bundle --file=Brewfile

brew-packages-mac:
	brew bundle --file=Brewfile-mac

plugin-managers: zap tpm

zap:
	zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1 --keep

tpm:
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

stow:
	stow */ -vt ~ --no-folding

stow-delete:
	stow -D */ --no-folding
