#!/bin/sh

sudo -v

# Keep-alive: update existing sudo time stamp if set, otherwise do nothing.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

function updateSystemAndInstallRequiredApps(){
    sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
    sudo dnf install rpmfusion-free-release-tainted rpmfusion-nonfree-release-tainted -y
    sudo dnf update -y
    sudo dnf upgrade -y
    sudo dnf group update core -y
    sudo dnf install -y fedora-workstation-repositories git unzip flatpak dconf-editor dnf-plugins-core ca-certificates util-linux fontconfig gnome-keyring libgnome-keyring
    sudo fwupdmgr refresh --force 
    sudo fwupdmgr get-devices 
    sudo fwupdmgr get-updates 
    sudo fwupdmgr update 
}

echo -e "Verifing and installing system updates, please wait..." 
updateSystemAndInstallRequiredApps > /dev/null 2>&1

# Run terminal installers
echo "Installing terminal tools and configs, please wait..."
for installer in ~/.local/share/omora/install/terminal/*.sh; do source "$installer"; done
echo "Terminal tools and configs completed successfuly."

