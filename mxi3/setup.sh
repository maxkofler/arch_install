#!/bin/bash

read -p "Are you sure to install mxi3? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]] ;
then
    echo ""
    echo "OK, let's go"
else
    echo ""
    echo "OK, you aborted!"
    exit 0;
fi


CURDIR=$(dirname $0)

echo "Running in $CURDIR"

echo "[setup] Installing packages..."

yay -Sy
yay -S alacritty dunst i3-gaps-rounded-git i3blocks i3status nitrogen neovim rofi nautilus neofetch polkit-gnome nerd-fonts-jetbrains-mono ttf-jetbrains-mono alacritty-themes lightdm lightdm-gtk-greeter lxappearance nordic-theme

echo "[setup] Installing vimplug (in nvim: 'PlugInstall'"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo "[setup] Backing up old .config..."
mv ~/.config ~/.old_config

echo "[setup] Copying new files..."
cp -rv $CURDIR/config ~/.config


