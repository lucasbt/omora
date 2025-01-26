function configEmojis(){
    cp ~/.local/share/omora/configs/xcompose ~/.XCompose
    ibus restart
    gsettings set org.gnome.desktop.input-sources xkb-options "['compose:caps']"
}

echo -e "Config emojis system..."
configEmojis > /dev/null 2>&1