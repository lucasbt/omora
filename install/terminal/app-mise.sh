# Install mise for managing multiple versions of languages. See https://mise.jdx.dev/
function addMise(){
    sudo dnf config-manager -y --add-repo https://mise.jdx.dev/rpm/mise.repo
    sudo dnf update -y
    sudo dnf install -y mise
}
echo -e "Installing Mise..."
addMise > /dev/null 2>&1