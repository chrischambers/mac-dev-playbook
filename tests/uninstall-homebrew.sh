#!/bin/bash
#
# Uninstalls Homebrew using the official uninstall script.

# Download and run the uninstall script.
curl -sLO https://raw.githubusercontent.com/Homebrew/install/master/uninstall.sh
chmod +x ./uninstall.sh
sudo ./uninstall.sh --force

# Clean up Homebrew directories.

# For pre m1 macs:
if [[ -d /usr/local/Homebrew ]]; then
    sudo rm -rf /usr/local/Homebrew
fi
if [[ -d /usr/local/Caskroom ]]; then
    sudo rm -rf /usr/local/Caskroom
fi
if [[ -f /usr/local/bin/brew ]]; then
    sudo rm -rf /usr/local/bin/brew
fi

# For post m1 macs:
if [[ -d /opt/homebrew ]]; then
    sudo rm -rf /opt/homebrew
fi
