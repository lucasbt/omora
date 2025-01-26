#set -e

if [ "$OMORA_DEBUG_MODE" == "true" ] || [ "$OMORA_DEBUG_MODE" -eq 1 ]; then
    OMORA_DEBUG_MODE=1
else
    OMORA_DEBUG_MODE=
fi

cat << "EOF"
 _______  __   __  _______  ______    _______ 
|       ||  |_|  ||       ||    _ |  |   _   |
|   _   ||       ||   _   ||   | ||  |  |_|  |
|  | |  ||       ||  | |  ||   |_||_ |       |
|  |_|  ||       ||  |_|  ||    __  ||       |
|       || ||_|| ||       ||   |  | ||   _   |
|_______||_|   |_||_______||___|  |_||__| |__|

EOF

echo -e "\\e[1;35mOMORA IS FOR FRESH FEDORA 40+ INSTALLATIONS ONLY! \\e[0m"
echo -e "\n\\e[1;32mBegin installation (or abort with ctrl+c)...\\e[0m\n"

echo -e "This script requires sudo to install packages and configure the system..."
echo -ne "Sudo applied? "
if sudo -n true 2> /dev/null; then
	echo -e "\r\033[KSudo applied? \\e[1;32mYES\033[0m"
else
	echo -e "\r\033[KSudo applied? \\e[1;31mNO\033[0m"
	sudo -v
fi

# Verifica se o parâmetro --dev-mode foi passado
if [ "$1" = "--dev-mode" ] || [ "$1" = "-d" ]; then
	echo -e "\n\033[0;93;5mAttention! The script is running in DEVELOPMENT MODE!\033[0m\n"
    OMORA_DEBUG_MODE=true
    echo -e "Copying local content to ~/.local/share/omora..."
	
    echo -ne "Creating target directory if it does not exist..."
    mkdir -p ~/.local/share/omora > /dev/null 2>&1
	rm -rf ~/.local/share/omora > /dev/null 2>&1
    echo -e "\rCreating target directory if it does not exist -> \\e[1;32mOK!\033[0m"

    echo -ne "Copying local development content..."
    cp -r . ~/.local/share/omora > /dev/null 2>&1
    echo -e "\rCopying local development content -> \\e[1;32mOK!\033[0m"

else
    echo -ne "Checking for system updates, please wait..."
    sudo dnf --refresh install -yq git
    echo -e "\r\033[KChecking for system updates -> \\e[1;32mOK!\033[0m"

    echo "Installing Omora..."
    rm -rf ~/.local/share/omora > /dev/null 2>&1
    git clone https://github.com/lucasbt/omora.git ~/.local/share/omora > /dev/null 2>&1
    if [[ $OMORA_REF != "main" ]]; then
        cd ~/.local/share/omora
        git fetch origin "${OMORA_REF:-main}" > /dev/null 2>&1
        git pull > /dev/null 2>&1
        cd - > /dev/null 2>&1
    fi
fi

source ~/.local/share/omora/install.sh

