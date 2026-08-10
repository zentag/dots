#!/usr/bin/env bash
cd -- "$(dirname -- "${BASH_SOURCE[0]}")" || exit
cd .. || exit

if ! hyprctl clients | grep "$(pwd)" >/dev/null; then
        ./helpers/neovim.sh "$(pwd)"
else
        hyprctl dispatch "hl.dsp.focus({ window = 'title:$(pwd)' })"
fi
sleep 2
while true; do
        if [ "$(hyprctl activeworkspace | head -n 1 | cut -c 14)" = "1" ]; then
                break
        fi
done

git add .
if ! sudo nixos-rebuild switch --flake .#"$(cat system.txt)"; then
        read -rp $'\nPress enter to rerun script'
        ./helpers/config.sh
        exit
fi
read -rp "Name of git commit (or enter for no commit): " name
if [ "$name" != "" ]; then
        git commit -m "$name"
        git push origin
else
        ./helpers/config.sh
        exit
fi
# this gets rid of shellcheck warning that it can't follow the new source
# shellcheck disable=SC1090
source ~/.zshrc &>/dev/null
exit
