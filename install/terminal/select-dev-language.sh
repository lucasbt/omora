# Install default programming languages
if [[ -v OMORA_FIRST_RUN_LANGUAGES && -n "$OMORA_FIRST_RUN_LANGUAGES" ]]; then
    languages=$OMORA_FIRST_RUN_LANGUAGES
else
    AVAILABLE_LANGUAGES=("Java" "Node.js" "Go" "Python" "Rust" "Ruby on Rails")
    languages=$(gum choose "${AVAILABLE_LANGUAGES[@]}" --no-limit --height 10 --header "Select programming languages")
fi


function installDevLanguages(){
    if [[ -n ${languages[@]} ]]; then
        for lang in "${languages[@]}"; do 
            case "$lang" in
                Ruby)
                    mise use --global ruby@3.3
                    mise x ruby -- gem install rails --no-document
                    ;;
                Node.js)
                    mise use --global node@lts
                    ;;
                Go)
                    mise use --global go@latest
                    ;;
                Python)
                    mise use --global python@latest
                    ;;
                Rust)
                    mise use -g rust@latest
                    ;;
                Java)
                    mise use --global java@17 java@21
                    ;;
            esac
        done
    fi
}

echo -e "Installing selected development languages..."
installDevLanguages > /dev/null 2>&1