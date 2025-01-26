function addDocker(){
    sudo dnf -y install dnf-plugins-core > /dev/null 2>&1
    sudo dnf config-manager -y --add-repo https://download.docker.com/linux/fedora/docker-ce.repo > /dev/null 2>&1

    sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-compose > /dev/null 2>&1

    # Limit log size to avoid running out of disk
    echo '{"log-driver":"json-file","log-opts":{"max-size":"10m","max-file":"5"}}' | sudo tee /etc/docker/daemon.json

    # Give this user privileged Docker access
    sudo groupadd docker
    sudo gpasswd -a ${USER} docker
    sudo groupadd -f docker
    sudo usermod -aG docker $USER    
    mkdir -p /home/"$USER"/.docker
    chown "$USER":"$USER" /home/"$USER"/.docker -R
    chmod g+rwx "$HOME/.docker" -R
    sudo systemctl enable --now docker.service
    sudo systemctl enable --now containerd.service

    docker run hello-world
}

echo -e "Installing and Config Docker..." 
addDocker > /dev/null 2>&1