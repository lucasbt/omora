# Make video calls using https://zoom.us/
function addZoom(){
    echo "Installing Zoom..."
    cd /tmp
    wget -q https://zoom.us/client/latest/zoom_x86_64.rpm 
    sudo dnf install -y -q ./zoom_x86_64.rpm --skip-broken &> /dev/null
    rm -rf zoom_x86_64.rpm &> /dev/null
    cd - &> /dev/null
    echo "Zoom has been installed."
}

echo -e "Installing Zoom..."
addZoom > /dev/null 2>&1