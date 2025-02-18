function addTypora(){
    mkdir -p ~/.local/share/typora
    curl https://download.typora.io/linux/Typora-linux-x64.tar.gz | tar xvz -C ~/.local/share/typora
    ln -s ~/.local/share/typora/bin/Typora-linux-x64/Typora /usr/local/bin/typora

    # Add iA Typora theme
    mkdir -p ~/.config/Typora/themes
    cp ~/.local/share/omora/configs/typora/ia_typora.css ~/.config/Typora/themes/
    cp ~/.local/share/omora/configs/typora/ia_typora_night.css ~/.config/Typora/themes/
}

echo -e "Installing and Config Typora..."
addTypora > /dev/null 2>&1