function addVSCode(){
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc 
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

    sudo dnf check-update -y &> /dev/null
    sudo dnf install code -yq --skip-broken

    mkdir -p ~/.config/Code/User
    cp ~/.local/share/omora/configs/vscode.json ~/.config/Code/User/settings.json

    # Install default supported themes
    code --install-extension enkia.tokyo-night
}

echo -e "Installing and Config Visual Studio Code..."
addVSCode > /dev/null 2>&1