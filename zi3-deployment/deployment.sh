clear
echo "[zi3] i3-deployment script by zimsneexh, made for Archlinux."
read -p "[zi3] The 'yay' aur helper is required for this installation. Continue? Y/N" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "[zi3] [1/4] [PACKAGES] Syncing packagelists..."
    yay -Sy
    echo "[zi3] [1/4] [PACKAGES] Installing dependencies..."
    yay -S alacritty dunst i3-gaps i3blocks i3status nitrogen neovim rofi nautilus neofetch polkit-gnome discord ttf-jetbrains-mono-git
    echo "[zi3] [1/4] [PACKAGES] Finished installing packages and dependencies.."
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    
    echo "[zi3] [2/4] [BACKUP] Moving old .config to .old_config ...  (Might display errors if certain dirs don't exist)"
    mv ~/.config ~/.old_config
    mv ~/.wallpapers ~/.old_wallpapers
    mv ~/.bin ~/.old_bin

    
    echo "[zi3] [3/4] [CONFIG] Deploying files.."
    cp ./.config ~/.config
    cp ./.wallpapers ~/.wallpapers
    cp ./.bin ~/.bin
    echo "[zi3] [4/4] Deployment done. zi3 successfully deployed on this system."
fi
    
echo "Exited.."
