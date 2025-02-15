SHELL := /bin/zsh
UNAME := $(shell uname -s)
USER  := $(shell whoami)

main: stow

plugin-managers: zap tpm

zap:
	zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1 --keep

tpm:
	git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

dirs:
	mkdir -p ~/.ssh && chmod 0700 ~/.ssh
	mkdir -p ~/.config/{git,tmux,zsh}

stow: dirs
	stow */ -vt ~ 

stow-delete:
	stow -D */ -vt ~
