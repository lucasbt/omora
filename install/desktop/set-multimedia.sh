function configMultimedia(){
    echo "Installing multimedia packages and groups..."
    sudo dnf config-manager --set-enabled fedora-cisco-openh264 -y
    sudo dnf --repo=rpmfusion-nonfree-tainted install "*-firmware" -y
    sudo dnf swap ffmpeg-free ffmpeg --allowerasing -y
    sudo dnf group upgrade -y --skip-broken --allowerasing --with-optional multimedia && sync
    sudo dnf install -y --skip-broken libdvdcss ffmpeg ffmpeg-libs libva libva-utils \
        gstreamer1-plugins-{bad-\*,good-\*,ugly-\*,base} gstreamer1-libav \
        openh264 gstreamer1-plugin-openh264 mozilla-openh264 gstreamer-ffmpeg lame\*  \
        --exclude=lame-devel --exclude=gstreamer1-plugins-bad-free-devel --best --allowerasing
    sudo dnf swap mesa-va-drivers mesa-va-drivers-freeworld -y --skip-broken --allowerasing
    sudo dnf swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld -y --skip-broken --allowerasing
    sudo dnf swap libva-intel-media-driver intel-media-driver -y --skip-broken --allowerasing
}
echo -e "Installing and Config Multimedia..."
configMultimedia > /dev/null 2>&1

gum style --foreground=212 --border-foreground=111 --border=rounded --align=left --padding="2 2" --width=$(( $(tput cols) - 10 )) \
    "Now, for Mozilla Firefox, you need open Firefox, go to menu -> Add-ons -> Plugins and enable OpenH264 plugin. You can do a simple test whether your H.264 works in RTC on this page (https://mozilla.github.io/webrtc-landing/pc_test.html). Go to webpage for finishing your configuration https://fedoraproject.org/wiki/OpenH264#Firefox_config_changes."

read -n 1 -s 