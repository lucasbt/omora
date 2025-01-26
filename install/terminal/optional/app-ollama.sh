echo -e "Installing Ollama AI..." 
function addOllama(){
    curl -fsSL https://ollama.com/install.sh | sh
}

addOllama > /dev/null 2>&1