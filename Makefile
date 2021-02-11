SHELL := /bin/zsh
UNAME := $(shell uname -s)
USER  := $(shell whoami)

ifeq ($(UNAME), Darwin)
  OS := macos
else ifeq ($(UNAME), Linux)
  OS := linux
endif

.PHONY: linux vscode

linux:
	sudo apt update
	sudo apt upgrade -y
	sudo apt autoclean
	sudo apt autoremove

install-brew:
	sudo -v
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

vscode:
	for EXTENSION in $(shell cat installs/vscode-extensions); do \
		code --install-extension $$EXTENSION; \
	done

vim:
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	vim +PlugInstall +qall +silent


stow:
	stow configs -t ~
