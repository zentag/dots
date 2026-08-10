#!/usr/bin/env bash
workspace="$(hyprctl activeworkspace | head -n 1 | cut -c 14)"
windowcount="$(hyprctl activeworkspace | grep windows | cut -c 11)"
hyprctl dispatch 'hl.dsp.window.close()'
if [ "$workspace" = "2" ] && [ "$windowcount" = "1" ]; then
        hyprctl dispatch 'hl.dsp.focus({ workspace = 1 })'
fi
