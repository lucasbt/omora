# Display system information in the terminal
function addFastfetch(){
    sudo dnf install -y fastfetch

    # Only attempt to set configuration if fastfetch is not already set
    if [ ! -f "$HOME/.config/fastfetch/config.jsonc" ]; then
        # Use custom fastfetch config
        mkdir -p ~/.config/fastfetch
        cp $OMORA_PATH/configs/fastfetch.jsonc ~/.config/fastfetch/config.jsonc
    fi
}

echo -e "Installing and Config Fastfetch..."
addFastfetch > /dev/null 2>&1