function configVirtualization(){
    sudo dnf group install virtualization --with-optional -y --skip-broken --allowerasing && sync
    sudo systemctl enable libvirtd
}
export -f configVirtualization
gum spin --show-error --title "Installing and Config Virtualization..." -- bash -c configVirtualization
unset -f configVirtualization
