# Favorite apps for dock
apps=(
	"google-chrome.desktop"
	"org.mozilla.firefox.desktop"
	"Alacritty.desktop"
	"Neovim.desktop"
	"code.desktop"
	"WhatsApp.desktop"
	"spotify.desktop"
	"md.obsidian.Obsidian.desktop"
	"Activity.desktop"
	"Docker.desktop"
	"org.gnome.Settings.desktop"
	"org.gnome.Nautilus.desktop"
	"localsend_app.desktop"
)

function configDock(){
	# Array to hold installed favorite apps
	installed_apps=()

	# Directory where .desktop files are typically stored
	desktop_dirs=(
		"/var/lib/flatpak/exports/share/applications"
		"/usr/share/applications"
		"/usr/local/share/applications"
		"$HOME/.local/share/applications"
	)

	# Check if a .desktop file exists for each app
	for app in "${apps[@]}"; do
		for dir in "${desktop_dirs[@]}"; do
			if [ -f "$dir/$app" ]; then
				installed_apps+=("$app")
				break
			fi
		done
	done

	# Convert the array to a format suitable for gsettings
	favorites_list=$(printf "'%s'," "${installed_apps[@]}")
	favorites_list="[${favorites_list%,}]"

	# Set the favorite apps
	gsettings set org.gnome.shell favorite-apps "$favorites_list"
}

echo -e "Config dock favorites apps..."
configDock > /dev/null 2>&1