#!/usr/bin/env bash
dir="${1:-$(pwd)}"
hyprctl dispatch exec "[workspace 2] ghostty --working-directory=$dir --title=$dir -e nvim $dir"
