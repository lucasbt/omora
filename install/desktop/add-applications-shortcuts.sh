echo -e "Adding Applications Shortcuts..."

for script in ~/.local/share/omora/applications/*.sh; do source $script; done
