#!/bin/bash

# Create a backup for settings iff no other backup has run in the previous hour.

set -x

backup_location="{{ ansible_env.HOME }}/backups/osx_settings/"
filename="$(date '+%Y-%m-%d-%H')"
target="${backup_location}/${filename}"

main() {
    mkdir -p "$backup_location"
    if [[ ! -f $target ]]; then
      defaults read > "$target"
    fi
}

main
