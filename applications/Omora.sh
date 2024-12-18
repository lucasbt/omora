cat <<EOF >~/.local/share/applications/Omora.desktop
[Desktop Entry]
Version=1.0
Name=Omora
Comment=Omora Controls
Exec=alacritty --config-file /home/$USER/.local/share/omora/defaults/alacritty/pane.toml --class=Omora --title=Omora -e omora
Terminal=false
Type=Application
Icon=/home/$USER/.local/share/omora/applications/icons/Omora.png
Categories=GTK;
StartupNotify=false
EOF
