function appEclipse(){
    ECLIPSE_URL_PACKAGES="https://www.eclipse.org/downloads/packages/"
    ECLIPSE_MIRROR_BR="https://eclipse.c3sl.ufpr.br"
    ECLIPSE_DIR="$HOME/.local/share/eclipse"
    ECLIPSE_ARCHIVE_NAME="eclipse-jee.tar.gz"
    ECLIPSE_DESKTOP_FILE_PATH="$HOME/.local/share/applications/eclipse.desktop"

    echo -e "Downloading and installing Eclipse JEE..."

    if [ -d "$ECLIPSE_DIR" ] && [ "$(ls -A "$ECLIPSE_DIR")" ]; then
        echo -e "Eclipse JEE is already installed. Skipping..."
    else
        # Use o comando curl para obter o conteúdo da URL e armazenar em uma variável
        HTML_CONTENT_URL=$(curl -s "$ECLIPSE_URL_PACKAGES")
        if [ $? -eq 0 ]; then
            # Use o grep para encontrar a tag HTML desejada no conteúdo HTML
            TAG_DOWNLOAD_CONTENT=$(echo "$HTML_CONTENT_URL" | grep -o '<a [^>]*href=["'\''][^"'\''"]*eclipse-jee[^"'\''"]*-linux-gtk-x86_64.tar.gz[^"'\''"]*["'\''][^>]*>.*</a>' | grep -o 'href=["'\''][^"'\''"]*["'\'']' | sed 's/href=//; s/["'"'"']//g')
            if [ -n "$TAG_DOWNLOAD_CONTENT" ]; then
                # Extrair o link da tag
                DOWNLOAD_LINK_ECLIPSE=$(echo "$TAG_DOWNLOAD_CONTENT" | awk -F'file=' '{print $2}' | cut -d'&' -f1)
                if [ -n "$DOWNLOAD_LINK_ECLIPSE" ]; then
                    # Use o awk para extrair o valor da query string "file"
                    #file_value=$(echo "$download_link" | awk -F'file=' '{print $2}' | cut -d'&' -f1)
                    DOWNLOAD_LINK_ECLIPSE="$ECLIPSE_MIRROR_BR$DOWNLOAD_LINK_ECLIPSE"
                    # Use o comando curl para baixar o conteúdo diretamente em memória
                    wget -q -nc -c -O "/tmp/$ECLIPSE_ARCHIVE_NAME" "$DOWNLOAD_LINK_ECLIPSE"
                    if [ $? -ne 0 ]; then
                        echo -e "Error downloading Eclipse JEE."
                    else
                        mkdir -p "$ECLIPSE_DIR"
                        tar --warning=no-unknown-keyword -xf "/tmp/$ECLIPSE_ARCHIVE_NAME" -C "$ECLIPSE_DIR" --strip-components=1 &> /dev/null
                        if [ $? -ne 0 ]; then
                            echo -e "Error extracting Eclipse JEE."
                        else
                            echo ""
                            chmod -R +rwx "$ECLIPSE_DIR"
                            ln -sf "$ECLIPSE_DIR/eclipse" "$HOME/.local/bin/eclipse"
                            
cat > "$ECLIPSE_DESKTOP_FILE_PATH" <<-EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Eclipse
Icon=$ECLIPSE_DIR/icon.xpm
Exec='$ECLIPSE_DIR/eclipse'
Comment=IDE for JEE
Categories=Development;IDE;
Terminal=false
StartupNotify=true
EOF
                            chmod +x "$ECLIPSE_DESKTOP_FILE_PATH"				
                            echo -e "Eclipse JEE was installed in $ECLIPSE_DIR"
                        fi
                    fi
                else
                    echo -e "Error retrieving Eclipse file download link '$DOWNLOAD_LINK_ECLIPSE'. Skipping..."
                fi
            else
                echo -e "No release of Eclipse JEE for Linux x86_64 found at '$URL_PACKAGES_ECLIPSE'. Skipping..."
            fi
        else
            echo -e "Error accessing Eclipse releases website. Skipping..."
        fi		
    fi
}

echo -e "Installing Eclipse IDE..."
appEclipse > /dev/null 2>&1