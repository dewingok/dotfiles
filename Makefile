SHELL := /bin/zsh
UNAME := $(shell uname -s)
USER  := $(shell whoami)

ifeq ($(UNAME), Darwin)
	OS := macos
else ifeq ($(UNAME), Linux)
	OS := linux
endif

main: $(OS) plugin-managers stow

linux:
	sudo -v
	command -v apt && sudo apt install zsh git tmux build-essential curl file
	command -v pacman && sudo pacman -Syu $(cat installs/pacman.list)

macos: brew-install brew-packages

brew-install:
	sudo -v
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

brew-packages:
	brew bundle --file=./installs/Brewfile
ifeq ($(UNAME), Darwin)
	brew bundle --file=./installs/Brewfile-mac
endif

plugin-managers: zap tpm

zap:
	zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1 --keep

tpm:
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

dirs:
	mkdir -p ~/tmp
	mkdir -p ~/.ssh
	chmod 0700 ~/.ssh

stow: dirs
	stow home -vt ~ --dotfiles --no-folding
	stow config -vt ~/.config
	stow local -vt ~/.local

stow-delete:
	stow -D home -vt ~ --dotfiles --no-folding
	stow -D config -vt ~/.config
	stow -D local -vt ~/.local

clean:
	rm -f *.deb
