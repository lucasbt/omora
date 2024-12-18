function configEmojis(){
    cp ~/.local/share/omora/configs/xcompose ~/.XCompose
    ibus restart
    gsettings set org.gnome.desktop.input-sources xkb-options "['compose:caps']"
}

export -f configEmojis
gum spin --show-error --title "Config emojis system..." -- bash -c configEmojis
unset -f configEmojis