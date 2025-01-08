function app1password(){
    sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc

    sudo sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=\"https://downloads.1password.com/linux/keys/1password.asc\"" > /etc/yum.repos.d/1password.repo'

    # Install 1Password & 1password-cli
    sudo dnf install -y 1password 1password-cli
}

export -f app1password
gum spin --show-error --title "Installing 1Password (Desktop and CLI)..." -- bash -c app1password
unset -f app1password