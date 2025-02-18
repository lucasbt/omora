# Alacritty is a GPU-powered and highly extensible terminal. See https://alacritty.org/
function installAlacritty(){
    sudo dnf install -yq alacritty --skip-broken
    mkdir -p ~/.config/alacritty
    cp ~/.local/share/omora/configs/alacritty.toml ~/.config/alacritty/alacritty.toml
    cp ~/.local/share/omora/themes/tokyo-night/alacritty.toml ~/.config/alacritty/theme.toml
    cp ~/.local/share/omora/configs/alacritty/fonts/CaskaydiaMono.toml ~/.config/alacritty/font.toml
    cp ~/.local/share/omora/configs/alacritty/font-size.toml ~/.config/alacritty/font-size.toml
}
echo -e "Installing and Config Alacritty..."
installAlacritty > /dev/null 2>&1