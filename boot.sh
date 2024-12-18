set -e

cat << "EOF"
 _______  __   __  _______  ______    _______ 
|       ||  |_|  ||       ||    _ |  |   _   |
|   _   ||       ||   _   ||   | ||  |  |_|  |
|  | |  ||       ||  | |  ||   |_||_ |       |
|  |_|  ||       ||  |_|  ||    __  ||       |
|       || ||_|| ||       ||   |  | ||   _   |
|_______||_|   |_||_______||___|  |_||__| |__|

EOF

echo -e ">> Omora is for fresh Fedora 40+ installations only! "
echo -e "\nBegin installation (or abort with ctrl+c)...\n"

echo -e "This script requires sudo to install packages and configure the system"
echo -ne "Sudo applied? "
if sudo -n true 2>/dev/null; then
	echo -e "\r\033[KSudo applied? YES"
else
	echo -e "\r\033[KSudo applied? NO"
	sudo -v
fi

# Verifica se o parâmetro --dev-mode foi passado
if [ "$1" = "--dev-mode" ] || [ "$1" = "-d" ]; then
	echo -e "\nAttention! The script is running in DEVELOPMENT MODE!\n"
    echo -e "Copying local content to ~/.local/share/omora..."
	
    echo -ne "Creating target directory if it does not exist..."
    mkdir -p ~/.local/share/omora >/dev/null
	rm -rf ~/.local/share/omora >/dev/null
    echo -e "\rCreating target directory if it does not exist -> OK!"

    echo -ne "Copying local development content..."
    cp -r . ~/.local/share/omora >/dev/null
    echo -e "\rCopying local development content -> OK!"

else
    echo -ne "Checking for system updates, please wait..."
    dnf --refresh check-update >/dev/null
    sudo dnf install -yq git
    echo -e "\r\033[KChecking for system updates -> OK!"

    echo "Installing Omora..."
    rm -rf ~/.local/share/omora
    git clone https://github.com/lucasbt/omora.git ~/.local/share/omora >/dev/null
    if [[ $OMORA_REF != "main" ]]; then
        cd ~/.local/share/omora
        git fetch origin "${OMORA_REF:-main}" >/dev/null
        git checkout FETCH_HEAD >/dev/null
        cd - >/dev/null
    fi
fi

echo "Component installation and system configuration started..."
source ~/.local/share/omora/install.sh
echo ""

