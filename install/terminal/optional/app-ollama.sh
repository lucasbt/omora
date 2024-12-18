function addOllama(){
    curl -fsSL https://ollama.com/install.sh | sh
}
export -f addOllama
gum spin --show-error --title "Installing Ollama AI..." -- bash -c addOllama
unset -f addOllama