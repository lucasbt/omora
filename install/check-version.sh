#!/bin/sh

# Function to check if running on Fedora 40 or higher
check_fedora_version() {
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    if [ "$ID" = "fedora" ]; then
      if awk -v ver="$VERSION_ID" 'BEGIN {exit !(ver >= 40)}'; then
        return 0
      else
        echo "Error: Fedora version must be 40 or higher. Current version: $VERSION_ID" >&2
        return 1
      fi
    else
      echo "Error: This script must be run on Fedora. Current OS: $ID" >&2
      return 1
    fi
  else
    echo "Error: Unable to determine OS. /etc/os-release file not found." >&2
    return 1
  fi
}

if ! check_fedora_version; then
  echo "Script execution failed due to system requirements not being met." >&2
  exit 1
fi
