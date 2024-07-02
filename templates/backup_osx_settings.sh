#!/bin/bash

set -x

backup_location="{{ ansible_env.HOME }}/backups/osx_settings/"
filename="$(date '+%Y-%m-%d').defaults.1"
target="${backup_location}/${filename}"

bump_osx_defaults_version_number() {
  echo "$(echo "$1" | awk -F. -v OFS=. '{$NF += 1 ; print}')"
}

main() {
    mkdir -p "$backup_location"
    while true; do
      if [[ -f $target ]]; then
        target=$(bump_osx_defaults_version_number "$target")
      else
        break
      fi
    done
    defaults read > "$target"
}

main
