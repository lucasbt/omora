CHOICES=(
	"Omora         Update Omora itself and run any migrations"
	"Ollama        Run LLMs, like Meta's Llama3, locally"
	"LazyGit       TUI for Git"
	"LazyDocker    TUI for Docker"
	"Neovim        Text editor that runs in the terminal"
	"Zellij        Adds panes, tabs, and sessions to the terminal"
	"Typora		   Editor Markdown"
	"Drawio        Diagram editor"
	"Bitwarden     Password Manager OSS"
	"Intellij      Leading Java and Kotlin editor"
	"Eclipse       The essential tools for Java developer"
	"<< Back       "
)

CHOICE=$(gum choose "${CHOICES[@]}" --height 10 --header "Update manually-managed applications")

if [[ "$CHOICE" == "<< Back"* ]] || [[ -z "$CHOICE" ]]; then
	# Don't update anything
	echo ""
else
	INSTALLER=$(echo "$CHOICE" | awk -F ' {2,}' '{print $1}' | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')

	case "$INSTALLER" in
	"omora") INSTALLER_FILE="$OMORA_PATH/bin/omora-sub/migrate.sh" ;;
	"typora") INSTALLER_FILE="$OMORA_PATH/install/desktop/app-$INSTALLER.sh" ;;
	"intellij" | "eclipse" | "bitwarden" | "drawio") INSTALLER_FILE="$OMORA_PATH/install/desktop/optional/app-$INSTALLER.sh" ;;
	"ollama") INSTALLER_FILE="$OMORA_PATH/install/terminal/optional/app-ollama.sh" ;;
	*) INSTALLER_FILE="$OMORA_PATH/install/terminal/app-$INSTALLER.sh" ;;
	esac

	source $INSTALLER_FILE && gum spin --spinner meter --title "Update completed!" -- sleep 3
fi

clear
source $OMORA_PATH/bin/omora
