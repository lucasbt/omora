# Load the PATH for use later in the installers
function addShellConfig(){
    source $HOME/.local/share/omora/defaults/bash/shell

    [ -f "~/.wgetrc" ] && mv ~/.wgetrc ~/.wgetrc.bak
    cp $OMORA_PATH/configs/wgetrc ~/.wgetrc

    [ -f "~/.gitconfig" ] && mv ~/.gitconfig ~/.gitconfig.bak
    cp $OMORA_PATH/configs/gitconfig ~/.gitconfig

    [ -f "~/.gitignore" ] && mv ~/.gitignore ~/.gitignore.bak
    cp $OMORA_PATH/configs/gitignore ~/.gitignore

    [ -f "~/.gitattributes" ] && mv ~/.gitattributes ~/.gitattributes.bak
    cp $OMORA_PATH/configs/gitattributes ~/.gitattributes

    [ -f "~/.bashrc" ] && mv ~/.bashrc ~/.bashrc.bak
    cp $OMORA_PATH/configs/bashrc ~/.bashrc

    [ -f "~/.inputrc" ] && mv ~/.inputrc ~/.inputrc.bak
    cp $OMORA_PATH/configs/inputrc ~/.inputrc
}

export -f addShellConfig
gum spin --show-error --title "Adding shell configs..." -- bash -c addShellConfig
unset -f addShellConfig
