function configVirtualization(){
    sudo dnf group install virtualization --with-optional -y --skip-broken --allowerasing && sync
    sudo systemctl enable libvirtd
}

echo -e "Installing and Config Virtualization..."
configVirtualization > /dev/null 2>&1
