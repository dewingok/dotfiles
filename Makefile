SHELL := /bin/zsh
UNAME := $(shell uname -s)
USER  := $(shell whoami)

ifeq ($(UNAME), Darwin)
  OS := macos
else ifeq ($(UNAME), Linux)
  OS := linux
endif

main: $(OS) brew-install brew-packages dirs vscode vim

linux: linux-brave linux-apt 

linux-apt:
	sudo apt update
	sudo apt upgrade -y
	sudo apt autoclean
	sudo apt autoremove

linux-brave:
	curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
	echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

macos: 

brew-install:
	sudo -v
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

brew-packages:
	brew bundle --file=./installs/Brewfile
ifeq ($(OS), macos)
	brew bundle --file=./installs/Brewfile-mac
endif

vscode:
	for EXTENSION in $(shell cat installs/vscode-extensions); do \
		code --install-extension $$EXTENSION; \
	done

vim:
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	vim +PlugInstall +qall +silent

dirs:
	[ ! -d "~/tmp" ] && mkdir ~/tmp
	[ ! -d "~/.ssh" ] && mkdir ~/.ssh
	chmod 0700 ~/.ssh

stow: dirs
	stow configs -t ~

clean:
	rm -f *.deb
