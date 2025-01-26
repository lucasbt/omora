echo -e "Installing Terminal Helpers..."

sudo dnf install -yq ripgrep bat eza zoxide xclip btop fd-find tldr zopfli plocate \
    unzip p7zip p7zip-plugins unrar sqlite lm_sensors pv dconf-editor util-linux fontconfig \
    bash-completion fuse-exfat gnome-terminal-nautilus inxi mediainfo gparted nmap pciutils rsync \
    symlinks youtube-dl bat fastfetch figlet htop jq lsd ncdu hplip hplip-common hplip-libs \
    exfat-utils eza timew cronie stow fzf --skip-broken > /dev/null 2>&1