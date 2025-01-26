function settingGnome(){
    # Center new windows in the middle of the screen
    gsettings set org.gnome.mutter center-new-windows true
    # Set Cascadia Mono as the default monospace font
    gsettings set org.gnome.desktop.interface monospace-font-name 'CaskaydiaMono Nerd Font 10'
    # Reveal week numbers in the Gnome calendar
    gsettings set org.gnome.desktop.calendar show-weekdate true
    gsettings set org.gnome.desktop.interface clock-format 24h
    gsettings set org.gnome.desktop.interface clock-show-date true
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    gsettings set org.gnome.desktop.interface enable-animations false
    gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'
    gsettings set org.gtk.Settings.FileChooser sort-directories-first true
    gsettings set org.gnome.TextEditor show-map true
    gsettings set org.gnome.TextEditor highlight-current-line true
    gsettings set org.gnome.TextEditor show-line-numbers true
    gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature 2500
    gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
    gsettings set org.gnome.desktop.peripherals.touchpad two-finger-scrolling-enabled true
    gsettings set org.gnome.desktop.wm.keybindings show-desktop ['<Super>d']
    gsettings set org.gtk.gtk4.Settings.FileChooser show-hidden true
    gsettings set org.gtk.gtk4.Settings.FileChooser view-type 'list'
    gsettings set org.gnome.desktop.background show-desktop-icons true
    gsettings set org.gnome.desktop.datetime automatic-timezone true
    gsettings set org.gnome.nautilus.preferences show-delete-permanently true
    gsettings set org.gnome.nautilus.preferences show-create-link true
}

echo -e "Config Gnome System..."
settingGnome > /dev/null 2>&1

