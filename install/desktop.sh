# Ensure computer doesn't go to sleep or lock while installing
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.session idle-delay 0

# Run desktop installers
echo "Installing default desktop apps and configs, please wait..."
for installer in ~/.local/share/omora/install/desktop/*.sh; do source $installer; done
echo "Terminal tools and configs completed successfuly."

gsettings set org.gnome.desktop.screensaver lock-enabled true
gsettings set org.gnome.desktop.session idle-delay 300