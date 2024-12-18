# Ensure computer doesn't go to sleep or lock while installing
gum spin --show-error --spinner dot --title "Installing default desktop apps and configs, please wait..." -- \
    gsettings set org.gnome.desktop.screensaver lock-enabled false \
    gsettings set org.gnome.desktop.session idle-delay 0 \
    for installer in ~/.local/share/omora/install/desktop/*.sh; do source $installer; done \
gsettings set org.gnome.desktop.screensaver lock-enabled true
gsettings set org.gnome.desktop.session idle-delay 300