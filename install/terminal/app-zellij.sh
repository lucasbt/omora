function addZellij(){
    cd /tmp
    wget -O zellij.tar.gz "https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz"
    tar -xf zellij.tar.gz zellij
    sudo install zellij /usr/local/bin
    rm zellij.tar.gz zellij
    cd -

    mkdir -p ~/.config/zellij/themes
    [ ! -f "$HOME/.config/zellij/config.kdl" ] && cp $OMORA_PATH/configs/zellij.kdl ~/.config/zellij/config.kdl
    cp $OMORA_PATH/themes/tokyo-night/zellij.kdl ~/.config/zellij/themes/tokyo-night.kdl
}

export -f addZellij
gum spin --show-error --title "Installing and Config Zellij..." -- bash -c addZellij
unset -f addZellij