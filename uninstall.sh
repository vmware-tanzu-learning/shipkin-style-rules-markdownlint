#!/bin/bash

platform=`uname`

if [ "$platform" == "Linux" ]; then
  vs_config_path="$HOME/.config/Code/User/settings.json"
else
  if [ "$platform" == "Mac" ]; then
    vs_config_path="$HOME/Library/Application Support/Code/User/settings.json"
  else
    echo "Platform not supported"
    exit 1
  fi
fi

echo "Removing custom user settings and custom markdownlint rules"

if [ -d "$HOME/.vscode/markdownlint/custom-rules" ]; then
  rm -rf "$HOME/.vscode/markdownlint/custom-rules"
  echo "Removed custom rules"
fi

backup_ext=.backup

if [ -f "$vs_config_path$backup_ext" ]; then

  mv $vs_config_path$backup_ext $vs_config_path
  echo "Restored backup settings"
fi