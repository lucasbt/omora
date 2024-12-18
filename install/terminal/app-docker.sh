# Add the official Docker repo
function addDocker(){
    sudo dnf -yq install dnf-plugins-core
    sudo dnf config-manager -yq --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

    sudo dnf install -yq docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-compose

    # Limit log size to avoid running out of disk
    echo '{"log-driver":"json-file","log-opts":{"max-size":"10m","max-file":"5"}}' | sudo tee /etc/docker/daemon.json

    # Give this user privileged Docker access
    sudo gpasswd -a ${USER} docker &> /dev/null
    sudo groupadd -f docker &> /dev/null
    sudo usermod -aG docker $USER &> /dev/null
    chown "$USER":"$USER" /home/"$USER"/.docker -R &> /dev/null
    chmod g+rwx "$HOME/.docker" -R &> /dev/null
    sudo systemctl enable --now docker.service &> /dev/null
    sudo systemctl enable --now containerd.service &> /dev/null

    docker run hello-world &> /dev/null
}

export -f addDocker
gum spin --show-error --title "Installing and Config Docker..." -- bash -c addDocker
unset -f addDocker

