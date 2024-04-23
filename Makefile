SHELL := /bin/zsh
UNAME := $(shell uname -s)
USER  := $(shell whoami)

ifeq ($(UNAME), Darwin)
  OS := macos
else ifeq ($(UNAME), Linux)
  OS := linux
endif

main: $(OS) brew-packages stow vscode vim

linux: linux-apt 

linux-apt:
	sudo apt update
	sudo apt upgrade -y
	sudo apt autoclean
	sudo apt autoremove
	< installs/apt-packages.txt xargs sudo apt install -y

macos: 

brew-install:
	sudo -v
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

brew-packages:
	brew bundle --file=./installs/Brewfile

dirs:
	mkdir -p ~/tmp
	mkdir -p ~/.ssh
	chmod 0700 ~/.ssh

stow: dirs
	stow dot-home -t ~ --dotfiles
	stow dot-config -t ~/.config
	stow dot-ssh -t ~/.ssh 

stow-delete:
	stow -D configs -t ~ --dotfiles
	stow -D configs-ssh -t ~/.ssh

clean:
	rm -f *.deb
