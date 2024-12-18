function addIntellijce(){
    PRODUCT_CODE_IIC="IIC"	
    IJ_URL_DL="https://download.jetbrains.com/product?code=${PRODUCT_CODE_IIC}&latest&distribution=linux"
    IJ_ARCHIVE_NAME="ideaIC.tar.gz"
    IJ_EXTRACTED_DIR_NAME="idea"
    IJ_DIR="$HOME/.local/share/$IJ_EXTRACTED_DIR_NAME"
    IJ_DESKTOP_FILE_PATH="$HOME/.local/share/applications/jetbrains-idea-ce.desktop"

    echo -e "Downloading and installing IntelliJ IDEA CE... "

    # Verificar se o IntelliJ IDEA já está instalado
    if [ -d "$IJ_DIR" ] && [ "$(ls -A "$IJ_DIR")" ]; then
        echo -e "IntelliJ IDEA CE is already installed. Skipping..."
    else
        wget -q -nc -c -O "/tmp/$IJ_ARCHIVE_NAME" "$IJ_URL_DL"
        # Verificar se o download foi bem-sucedido
        if [ $? -ne 0 ]; then
            echo -e "Downloading and installing IntelliJ IDEA CE... FAIL - Download fail."
        else
            mkdir -p "$IJ_DIR"
            tar --warning=no-unknown-keyword -xf "/tmp/$IJ_ARCHIVE_NAME" -C "$IJ_DIR" --strip-components=1 &> /dev/null
            if [ $? -ne 0 ]; then
                echo -e "Downloading and installing IntelliJ IDEA CE... FAIL - Error extracting IntelliJ IDEA."
            else
                echo ""
                chmod -R +rwx "$IJ_DIR"
                ln -sf "$IJ_DIR/bin/idea.sh" "$HOME/.local/bin/idea"
                
cat > "$IJ_DESKTOP_FILE_PATH" <<-EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=IntelliJ IDEA CE
Icon=$IJ_DIR/bin/idea.svg
Exec='$IJ_DIR/bin/idea.sh' %f
Comment=Capable and Ergonomic IDE for JVM
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-idea-ce
StartupNotify=true
EOF
                
                chmod +x "$IJ_DESKTOP_FILE_PATH"	
                echo -e "IntelliJ IDEA CE was installed in $IJ_DIR"
            fi
        fi
    fi
}

export -f addIntellijce
gum spin --show-error --title "Installing IntelliJ CE IDE..." -- bash -c addIntellijce
unset -f addIntellijce