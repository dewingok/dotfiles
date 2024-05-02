#!/bin/bash
# Script for performing a quick backup.

# What to backup
backup_files=".histfile Documents Pictures bin bookmarks-*.json brew_list_backup"
backup_git="github"


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

cd $HOME || exit
brew list > brew_list_backup
tar czf ${dest}/${archive_file} ${backup_files}
tar czf ${dest}/${archive_repos} ${backup_git}

# Print end status message.
echo
echo "Backup finished"
date
