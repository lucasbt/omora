function setOptimization(){
    sudo grubby --update-kernel=ALL --args="mitigations=off"
    sudo systemctl disable NetworkManager-wait-online.service
    sudo grubby --update-kernel=ALL --args="mem_sleep_default=s2idle"
    sudo rm -rf /etc/xdg/autostart/org.gnome.Software.desktop
}
export -f setOptimization
gum spin --show-error --title "Optimization system..." -- bash -c setOptimization
unset -f setOptimization