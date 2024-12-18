function appBrave(){
    echo "Installing Brave..."
    sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo &> /dev/null
    sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc &> /dev/null
    sudo dnf install brave-browser -y --skip-broken &> /dev/null
    echo "Brave has been installed."
}
export -f appBrave
gum spin --show-error --title "Installing Brave Browser..." -- bash -c appBrave
unset -f appBrave