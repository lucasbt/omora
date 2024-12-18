# Display system information in the terminal
function addFastfetch(){
  sudo dnf install -yq fastfetch

  # Only attempt to set configuration if fastfetch is not already set
  if [ ! -f "$HOME/.config/fastfetch/config.jsonc" ]; then
    # Use custom fastfetch config
    mkdir -p ~/.config/fastfetch
    cp $OMORA_PATH/configs/fastfetch.jsonc ~/.config/fastfetch/config.jsonc
  fi
}

export -f addFastfetch
gum spin --show-error --title "Installing and Config Fastfetch..." -- bash -c addFastfetch
unset -f addFastfetch