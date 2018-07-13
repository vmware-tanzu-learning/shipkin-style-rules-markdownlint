#!/bin/bash

platform=`uname`

if [ ! -d "$HOME/.vscode/markdownlint/custom-rules" ]; then
  mkdir -p "$HOME/.vscode/markdownlint/custom-rules"
fi

cp -rf src/markdownlint/custom-rules/* $HOME/.vscode/markdownlint/custom-rules/

if [ "$platform" == "Linux" ]; then
  vs_config_path="$HOME/.config/Code/User/settings.json"
else
  if [ "$platform" == "Darwin" ]; then
    vs_config_path="$HOME/Library/Application Support/Code/User/settings.json"
  else
    echo "Platform not supported"
    exit 1
  fi
fi

echo "Installing custom user settings and custom markdownlint rules"


if [ -f "$vs_config_path" ]; then
  backup_ext=.backup
  mv $vs_config_path $vs_config_path$backup_ext
  echo "Backed up settings to $vs_config_path$backup_ext"
fi

home_env_var="\$HOME"
echo "home_env_var -> " $home_env_var
home_env=$HOME
echo "home_env ->" $home_env

sed -e "s~$home_env_var~$home_env~" settings.json > $vs_config_path

echo "Copied new user settings, merge your custom settings from the backup"
