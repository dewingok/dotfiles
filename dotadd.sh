#!/usr/bin/env bash

dotadd() {
  if [[ $# -ne 2 ]]; then
    printf 'usage: dotadd <package> <path>\n' >&2
    return 1
  fi

  local package="$1"
  local source_arg="$2"
  local source
  local dotfiles="${DOTFILES:-$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)}"
  local home_path source_parent source_path source_target
  local relative destination

  if [[ -z "$package" || -z "$source_arg" ]]; then
    printf 'usage: dotadd <package> <path>\n' >&2
    return 1
  fi

  case "$package" in
    -*|*/*|.|..)
      printf 'error: package must be a directory name\n' >&2
      return 1
      ;;
  esac

  case "$source_arg" in
    \~) source="$HOME" ;;
    \~/*) source="$HOME/${source_arg:2}" ;;
    *) source="$source_arg" ;;
  esac

  if ! home_path="$(realpath "$HOME")"; then
    printf 'error: unable to resolve %s\n' "\$HOME" >&2
    return 1
  fi

  if ! source_parent="$(realpath "$(dirname -- "$source")")"; then
    printf 'error: unable to resolve path: %s\n' "$source_arg" >&2
    return 1
  fi
  source_path="$source_parent/$(basename -- "$source")"

  if ! source_target="$(realpath "$source_path")"; then
    printf 'error: path does not exist: %s\n' "$source_arg" >&2
    return 1
  fi

  case "$source_path" in
    "$home_path"/*) ;;
    *)
      printf 'error: path must be under %s\n' "\$HOME" >&2
      return 1
      ;;
  esac

  case "$source_target" in
    "$home_path"/*) ;;
    *)
      printf 'error: path must resolve under %s\n' "\$HOME" >&2
      return 1
      ;;
  esac

  if [[ ! -d "$dotfiles" ]]; then
    printf 'error: dotfiles repository not found: %s\n' "$dotfiles" >&2
    return 1
  fi
  dotfiles="$(realpath "$dotfiles")" || return 1

  case "$source_path" in
    "$dotfiles"|"$dotfiles"/*)
      printf 'error: source path is already inside the dotfiles repository\n' >&2
      return 1
      ;;
  esac

  if ! command -v stow >/dev/null 2>&1; then
    printf 'error: stow is not installed\n' >&2
    return 1
  fi

  relative="${source_path#"$home_path"/}"
  destination="$dotfiles/$package/$relative"

  if [[ -e "$destination" || -L "$destination" ]]; then
    printf 'error: already exists: %s\n' "$destination" >&2
    return 1
  fi

  if ! mkdir -p "$(dirname -- "$destination")"; then
    printf 'error: unable to create destination: %s\n' "$destination" >&2
    return 1
  fi

  if ! mv -- "$source_path" "$destination"; then
    printf 'error: unable to move %s\n' "$source_arg" >&2
    return 1
  fi

  if ! (cd -- "$dotfiles" && stow --target="$HOME" "$package"); then
    printf 'error: stow failed; restoring %s\n' "$source_arg" >&2
    if ! mv -- "$destination" "$source_path"; then
      printf 'error: unable to restore %s\n' "$source_arg" >&2
    fi
    return 1
  fi

  (cd -- "$dotfiles" && git status)
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  dotadd "$@"
fi
