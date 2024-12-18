cat <<EOF >~/.local/share/applications/Typora.desktop
[Desktop Entry]
Version=1.0
Type=Application
Name=Typora
Exec=typora --enable-features=UseOzonePlatform --ozone-platform=wayland %F
Icon=/home/$USER/.local/share/omora/applications/icons/Typora.png
Comment=Markdown Editor
Categories=Development;TextEditor
Terminal=false
StartupNotify=true
MimeType=text/markdown
EOF