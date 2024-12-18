# Install mise for managing multiple versions of languages. See https://mise.jdx.dev/
function addMise(){
    sudo dnf config-manager -y --add-repo https://mise.jdx.dev/rpm/mise.repo
    sudo dnf update -y
    sudo dnf install -y mise
}

export -f addMise
gum spin --show-error --title "Installing Mise..." -- bash -c addMise
unset -f addMise