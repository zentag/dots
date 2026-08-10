#!/usr/bin/env bash
dir="${1:-$(pwd)}"
hyprctl dispatch "hl.dsp.exec_cmd('ghostty --working-directory=$dir --title=$dir -e nvim $dir', { workspace = \"2\" })"
