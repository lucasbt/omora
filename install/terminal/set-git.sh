# Set common git aliases
function setGitAliases(){
    git config --global alias.co checkout
    git config --global alias.br branch
    git config --global alias.ci commit
    git config --global alias.st status
    git config --global pull.rebase true
    # Configurar ferramenta de merge padrão
    git config --global merge.tool vimdiff
    git config --global mergetool.prompt true
}

export -f setGitAliases
gum spin --show-error --title "Setting git aliases.." -- bash -c setGitAliases
unset -f setGitAliases

git_username=$(gum input --header "What name do you want to use for git commits?" --placeholder "Enter your username to use in Git..." --header.foreground="Gray")
git_email=$(gum input --header "What email do you want to use for git commits?" --placeholder "Enter your email to use in Git..." --header.foreground="Gray")

git config --global user.name "$git_username"
git config --global user.email "$git_email"

