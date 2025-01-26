#!/bin/sh

export OMORA_PATH="/home/$USER/.local/share/omora"

# Desktop software and tweaks will only be installed if we're running Gnome
RUNNING_GNOME=$([[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]] && echo true || echo false)

# Função de limpeza a ser chamada em caso de erro ou interrupção
function cleanup() {
	# Captura o sinal que invocou o trap
    local signal="$1"
	tput cnorm # Volta o cursor ao normal
    echo -e "\n\\e[1;31mIntercepted signal or error. Performing cleanup...\\e[0m"
    # Exibe o erro ou sinal que causou o acionamento da função
    if [[ -n "$signal" ]]; then
        echo -e "\\e[1;31mError or signal received: $signal\\e[0m"
    fi

	if $RUNNING_GNOME; then
		gsettings set org.gnome.desktop.screensaver lock-enabled true
		gsettings set org.gnome.desktop.session idle-delay 300
	fi
	echo -e "\nBye!\n"
}
trap cleanup SIGINT
trap cleanup SIGTERM
trap cleanup ERR
trap cleanup SIGKILL

# Check the distribution name and version and abort if incompatible
source ~/.local/share/omora/install/check-version.sh

echo -e "Installing tools used by Omora"
source ~/.local/share/omora/install/terminal/required/app-gum.sh 
sudo dnf install -yq curl wget flatpak > /dev/null 2>&1

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
gum confirm "Ready to reboot for all settings to take effect?" && sudo reboot || echo -e "\nBye!\n"