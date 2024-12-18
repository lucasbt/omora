UNINSTALLER=$(gum file $OMORA_PATH/uninstall --height 26)
[ -n "$UNINSTALLER" ] && gum confirm "Run uninstaller?" && source $UNINSTALLER && gum spin --spinner meter --title "Uninstall completed!" -- sleep 3
clear
source $OMORA_PATH/bin/omora
