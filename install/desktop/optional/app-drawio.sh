function appDrawio(){
    echo "Installing Drawio..."
    cd /tmp
    curl -s https://api.github.com/repos/jgraph/drawio-desktop/releases/latest | grep browser_download_url | grep 'drawio-x86_64.*\.rpm' | cut -d '"' -f 4 | wget -q -i -
    sudo dnf install ./drawio-x86_64-*.rpm -y --skip-broken &> /dev/null
    cd -
    echo "Drawio has been installed."
}


export -f appDrawio
gum spin --show-error --title "Installing Drawio..." -- bash -c appDrawio
unset -f appDrawio