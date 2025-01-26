function configAppGrid(){
    # Remove Btop entry for one that runs in alacritty
    sudo rm -rf /usr/share/applications/btop.desktop

    # App doesn't do anything when started from the app grid
    sudo rm -rf /usr/share/applications/org.flameshot.Flameshot.desktop

    # Remove the ImageMagick icon
    sudo rm -rf /usr/share/applications/display-im6.q16.desktop

    # We added our own meant for Alacritty
    sudo rm -rf /usr/local/share/applications/nvim.desktop
    sudo rm -rf /usr/local/share/applications/vim.desktop
}

echo -e "Config App Grid..."
configAppGrid > /dev/null 2>&1