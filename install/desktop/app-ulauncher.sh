function addUlauncher(){
    sudo dnf install ulauncher -yq --skip-broken

    # Start ulauncher to have it populate config before we overwrite
    mkdir -p ~/.config/autostart/
    cp ~/.local/share/omora/configs/ulauncher.desktop ~/.config/autostart/ulauncher.desktop
    gtk-launch ulauncher.desktop >/dev/null 2>&1
    sleep 5 # ensure enough time for ulauncher to set defaults
    cp ~/.local/share/omora/configs/ulauncher.json ~/.config/ulauncher/settings.json
}

export -f addUlauncher
gum spin --show-error --title "Installing and Config Ulauncher..." -- bash -c addUlauncher
unset -f addUlauncher
