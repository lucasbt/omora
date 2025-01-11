if [ $# -eq 0 ]; then
	#SUB=$(gum choose "Theme" "Font" "Update" "Install" "Uninstall" "Manual" "Quit" --height 10 --header "" | tr '[:upper:]' '[:lower:]')
	SUB=$(gum choose "Theme" "Font" "Update" "Install" "Manual" "Quit" --height 10 --header "" | tr '[:upper:]' '[:lower:]')
else
	SUB=$1
fi

[ -n "$SUB" ] && [ "$SUB" != "quit" ] && source $OMORA_PATH/bin/omora-sub/$SUB.sh
