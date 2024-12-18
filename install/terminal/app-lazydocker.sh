function addLazydocker(){
    cd /tmp
    local LAZYDOCKER_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazydocker/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -sLo lazydocker.tar.gz "https://github.com/jesseduffield/lazydocker/releases/latest/download/lazydocker_${LAZYDOCKER_VERSION}_Linux_x86_64.tar.gz" 
    tar -xf lazydocker.tar.gz lazydocker 
    sudo install lazydocker /usr/local/bin 
    rm -rf lazydocker.tar.gz lazydocker
    cd - &> /dev/null
}

export -f addLazyDocker
gum spin --show-error --title "Installing and Config LazyDocker..." -- bash -c addLazyDocker
unset -f addLazyDocker
