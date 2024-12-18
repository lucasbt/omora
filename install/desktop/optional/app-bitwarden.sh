function appBitwarden(){
    echo "Installing Bitwarden Desktop..."
    sudo dnf install bitwarden -y -q --skip-broken &> /dev/null

    echo "Installing Bitwarden CLI..."
    filename=bw-linux-x64
    app_name=bw

    # Verifica se o arquivo já existe nos diretórios /tmp ou /usr/local/bin
    if [[ ! -e "/usr/local/bin/$app_name" ]]; then
        link=$(curl -sL https://api.github.com/repos/bitwarden/clients/releases | jq -r '.[] | .assets[] | select(.name | startswith("bw-linux")) | select(.name | endswith(".zip")) | .browser_download_url' | head -n 1)

        if [[ -n "$link" ]]; then        
            # Verifica se o arquivo já existe em /tmp antes de fazer o download
            if [[ ! -e "/tmp/$filename" ]]; then
                curl -sL "$link" -o "/tmp/$filename" &> /dev/null
            fi
            unzip -o /tmp/$filename -d /tmp &> /dev/null
            chmod +x "/tmp/$app_name"
            sudo mv "/tmp/$app_name" "/usr/local/bin"
            echo "Bitwarden has been installed."
        else
            echo "Error: Impossible find installer '$app_name' in remote location."
        fi
    fi
}
export -f appBitwarden
gum spin --show-error --title "Installing Bitwarden (Desktop and CLI)..." -- bash -c appBitwarden
unset -f appBitwarden