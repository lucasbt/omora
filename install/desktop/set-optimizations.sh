function setOptimization(){
    sudo grubby --update-kernel=ALL --args="mitigations=off"
    sudo systemctl disable NetworkManager-wait-online.service
    sudo grubby --update-kernel=ALL --args="mem_sleep_default=s2idle"
    sudo rm -rf /etc/xdg/autostart/org.gnome.Software.desktop
}

echo -e "Optimization system..."
setOptimization > /dev/null 2>&1