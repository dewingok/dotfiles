#!/bin/bash

# What to backup
home_dir="/Users/ndewing"
# backup_files=".atom/config.cson .aws .gitconfig .gitignore_global .gnupg .histfile .ssh .tmux.conf .tmuxinator .vim .vimrc .zsh .zshrc Brewfile Documents Pictures bin requirements.txt bookmarks-*.json brew_list_backup"
backup_files=".atom/config.cson .aws .gitconfig .gitignore_global .ssh .tmux.conf .tmuxinator .vim .vimrc .zsh .zshrc Brewfile Pictures bin/backup.sh bin/ssh_cfg_gen.py requirements.txt brew_list_backup"
backup_git="intuit"


# Where to backup
dest="${home_dir}"

# Archive naming
date=$(date +%F)
archive_file="backup-${date}.tgz"
archive_repos="repo-backup-${date}.tgz"

# Print start status message.
echo "Backing up $backup_files to $dest/$archive_file"
date
echo

cd ${home_dir} || exit
brew list > brew_list_backup
tar czf ${dest}/${archive_file} ${backup_files}
tar czf ${dest}/${archive_repos} ${backup_git}

# Print end status message.
echo
echo "Backup finished"
date
