set_font() {
	local font_name=$1
	local url=$2
	local file_type=$3
	local file_name="${font_name/ Nerd Font/}"

	if ! $(fc-list | grep -i "$font_name" >/dev/null); then
		cd /tmp
		wget -O "$file_name.zip" "$url"
		unzip "$file_name.zip" -d "$file_name"
		cp "$file_name"/*."$file_type" ~/.local/share/fonts
		rm -rf "$file_name.zip" "$file_name"
		fc-cache
		cd -
	fi

	gsettings set org.gnome.desktop.interface monospace-font-name "$font_name 10"
	cp "$OMORA_PATH/configs/alacritty/fonts/$file_name.toml" ~/.config/alacritty/font.toml
	sed -i "s/\"editor.fontFamily\": \".*\"/\"editor.fontFamily\": \"$font_name\"/g" ~/.config/Code/User/settings.json
}

if [ "$#" -gt 1 ]; then
	choice=${!#}
else
	choice=$(gum choose "Cascadia Mono" "Fira Mono" "JetBrains Mono" "Meslo" "> Change size" "<< Back" --height 8 --header "Choose your programming font")
fi

# Definir os parâmetros das fontes
declare -A fonts=(
  ["Cascadia Mono"]="CaskaydiaMono Nerd Font https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaMono.zip ttf"
  ["Fira Mono"]="FiraMono Nerd Font https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraMono.zip otf"
  ["JetBrains Mono"]="JetBrainsMono Nerd Font https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip ttf"
  ["Meslo"]="MesloLGS Nerd Font https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.zip ttf"
)

case $choice in
  "Cascadia Mono" | "Fira Mono" | "JetBrains Mono" | "Meslo")
    IFS=' ' read -r font_name font_url font_extension <<< "${fonts[$choice]}"
	export -f set_font
    gum spin --show-error --title "Setting the preferred monospace font on the system..." -- bash -c \
      "set_font \"$font_name\" \"$font_url\" \"$font_extension\""
	unset -f set_font
    ;;
  "> Change size")
    source $OMORA_PATH/bin/omora-sub/font-size.sh
    exit
    ;;
esac

source $OMORA_PATH/bin/omora-sub/menu.sh