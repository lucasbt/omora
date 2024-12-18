#!/bin/sh

# Exit immediately if a command exits with a non-zero status
set -e

# Desktop software and tweaks will only be installed if we're running Gnome
RUNNING_GNOME=$([[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]] && echo true || echo false)

# Função de limpeza a ser chamada em caso de erro ou interrupção
cleanup() {
    echo -e "\nIntercepted signal or error. Performing cleanup..."
    rm -rf ~/.local/share/omora
	if $RUNNING_GNOME; then
		gsettings set org.gnome.desktop.screensaver lock-enabled true
		gsettings set org.gnome.desktop.session idle-delay 300
	fi
    exit 1
}
trap cleanup INT TERM ERR

# Check the distribution name and version and abort if incompatible
source ~/.local/share/omora/install/check-version.sh

echo -ne "Installing tools used by Omora, please wait..."
source ~/.local/share/omora/install/terminal/required/app-gum.sh >/dev/null
sudo dnf install -yq curl wget flatpak >/dev/null 2>&1;
echo -e "\r\033[KInstalling tools used by Omora -> OK!"

echo "Get ready to make a few choices..."
source ~/.local/share/omora/install/first-run-choices.sh

if $RUNNING_GNOME; then
	# Ensure computer doesn't go to sleep or lock while installing
	gsettings set org.gnome.desktop.screensaver lock-enabled false
	gsettings set org.gnome.desktop.session idle-delay 0

	echo "Installing terminal and desktop tools.."
else
	echo "Only installing terminal tools..."
fi

# Install terminal tools
source ~/.local/share/omora/install/terminal.sh

if $RUNNING_GNOME; then
	# Install desktop tools and tweaks
	source ~/.local/share/omora/install/desktop.sh
	# Revert to normal idle and lock settings
	gsettings set org.gnome.desktop.screensaver lock-enabled true
	gsettings set org.gnome.desktop.session idle-delay 300
fi

# Logout to pickup changes
gum confirm "Ready to reboot for all settings to take effect?" && sudo reboot