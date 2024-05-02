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
	stow configs -t ~ --dotfiles
	stow configs-ssh -t ~/.ssh 

vscode:
	for EXTENSION in $(shell cat installs/vscode-extensions); do \
		code --install-extension $$EXTENSION; \
	done

vim:
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	vim +PlugInstall +qall +silent

stow-delete:
	stow -D configs -t ~ --dotfiles
	stow -D configs-ssh -t ~/.ssh

clean:
	rm -f *.deb
