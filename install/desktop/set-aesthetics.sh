MS_FONTS_VERSION="2.6-1"
FONTS_DOTS_DIR="~/.local/share/fonts"

FONTS_FAVORITES_LIST=(
    CascadiaCode
    CascadiaMono
    Cousine
    FiraCode
    FiraMono
    Hack
    iA-Writer
    IBMPlexMono
    Inconsolata
    Iosevka
    IosevkaTerm
    IosevkaTermSlab
    JetBrainsMono
    Meslo
    Noto
    RobotoMono
    SourceCodePro
    UbuntuMono
    Ubuntu
)

ICONS_FAVORITES_LIST=(
	papirus-icon-theme-dark
	papirus-icon-theme-light
	flat-remix-icon-theme
	pop-icon-theme
	paper-icon-theme
	luv-icon-theme
	libreoffice-icon-theme-papirus
)

function setFonts(){
    mkdir -p ~/.local/share/fonts
    echo -e "Downloading and installing preferred fonts..."
    FONT_URL_DL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download"

    mkdir -p "/tmp/fonts/"
    for FONT in "${FONTS_FAVORITES_LIST[@]}"; do
        if [[ $FONT != "" ]] && [[ $FONT != "#"* ]]; then
            wget -nv -c --force-progress -O "/tmp/fonts/$FONT.zip" "$FONT_URL_DL/$FONT.zip"
            if [ $? -eq 0 ]; then
                mkdir -p "$FONTS_DOTS_DIR/$FONT/"
                unzip -qq -o "/tmp/fonts/$FONT.zip" -d "$FONTS_DOTS_DIR/$FONT/"
            fi
        fi
    done

    URL_MSFONTS="https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-${MS_FONTS_VERSION}.noarch.rpm"
    sudo dnf --nogpgcheck install -yq --skip-broken ${URL_MSFONTS}
    fc-cache -f
    echo -e "Preferred fonts installation complete."
}

function setIcons(){
    echo -e "Downloading and installing preferred icons..."
    sudo dnf install -yq ${ICONS_FAVORITES_LIST[@]} --skip-broken
    echo -e "Preferred icons installation complete."
}

export -f setFonts setIcons
gum spin --show-error --title "Downloading and installing preferred fonts..." -- bash -c setFonts
gum spin --show-error --title "Downloading and installing preferred icons..." -- bash -c setIcons
unset -f setFonts setIcons