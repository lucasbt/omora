#!/bin/sh

OPTIONAL_APPS=("1Password" "Bitwarden" "Spotify" "Telegram" "Brave" "IntelliJ" "OnlyOffice" "Drawio")
DEFAULT_OPTIONAL_APPS='Bitwarden,Spotify,Telegram,Brave,IntelliJ,OnlyOffice,1Password,Drawio'
export  OMORA_FIRST_RUN_OPTIONAL_APPS=$(gum choose "${OPTIONAL_APPS[@]}" --no-limit --selected $DEFAULT_OPTIONAL_APPS --height 7 --header "Select optional apps" | tr ' ' '-')

AVAILABLE_LANGUAGES=("Java" "Node.js" "Go" "Python" "Rust" "Ruby on Rails")
SELECTED_LANGUAGES="Java","Node.js","Go","Rust","Python"
export OMORA_FIRST_RUN_LANGUAGES=$(gum choose "${AVAILABLE_LANGUAGES[@]}" --no-limit --selected "$SELECTED_LANGUAGES" --height 10 --header "Select programming languages")