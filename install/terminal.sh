#!/bin/sh

sudo -v

# Keep-alive: update existing sudo time stamp if set, otherwise do nothing.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

function updateSystemAndInstallRequiredApps(){
    sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -yq
    sudo dnf install rpmfusion-free-release-tainted rpmfusion-nonfree-release-tainted -yq
    sudo dnf update -yq
    sudo dnf upgrade -yq
    sudo dnf group update core -yq
    sudo dnf install -yq fedora-workstation-repositories git unzip flatpak dconf-editor dnf-plugins-core ca-certificates util-linux fontconfig gnome-keyring libgnome-keyring
    sudo fwupdmgr refresh --force &> /dev/null
    sudo fwupdmgr get-devices &> /dev/null
    sudo fwupdmgr get-updates &> /dev/null
    sudo fwupdmgr update &> /dev/null
}

echo "First, let's update the system and install required applications..."
export -f updateSystemAndInstallRequiredApps
gum spin --show-error --title "Verifing and installing system updates, please wait..." -- bash -c updateSystemAndInstallRequiredApps
unset -f updateSystemAndInstallRequiredApps
echo "System update and installation of required applications completed successfully."

# Run terminal installers
echo "Installing terminal tools and configs, please wait..."
for installer in ~/.local/share/omora/install/terminal/*.sh; do source "$installer"; done
echo "Terminal tools and configs completed successfuly."

