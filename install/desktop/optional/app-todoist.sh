function addTodoist(){
    echo "Installing Todoist..."
    cd /tmp
    filename=todoist
    curl -sL https://todoist.com/linux_app/appimage -o "/tmp/$filename" &> /dev/null
    ail-cli integrate "/tmp/$filename" &> /dev/null
    cd - &> /dev/null
    echo "Todoist has been installed."
}

echo -e "Installing Todoist..."
addTodoist > /dev/null 2>&1