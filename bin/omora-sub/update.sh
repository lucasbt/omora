CHOICES=(
	"Omora         Update Omora itself and run any migrations"
	"LazyGit       TUI for Git"
	"LazyDocker    TUI for Docker"
	"Neovim        Text editor that runs in the terminal"
	"Zellij        Adds panes, tabs, and sessions to the terminal"
	"Bitwarden     Best OSS app for manage your passwords securely across devices"
	"1Password     Best Commercial app for manage your passwords securely across devices"
	"Discord       Messaging, voice and video client"
	"Telegram      Messaging app with a focus on security and speed"
	"Brave         Chrome-based browser with built-in ad blocking"
	"Amberol       Plays music, and nothing else"
	"Dropbox       Sync files across computers with ease"
	"Drawio       Diagramming tool"
	"Foliate       Read e-books in style"
	"Ollama        Run LLMs, like Meta's Llama3, locally"
	"OnlyOffice    Office productivity suite"
	"Spotify       Stream music from the world's most popular service"
	"Parabolic     Download web video and audio (yt-dlp frontend)"
	"Planify       Task manager designed for GNOME (Todoist & Nextcloud support)"
	"Todoist       To-Do List & Tasks"
	"Zoom          Attend and host video chat meetings"
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
	"intellij" | "eclipse" | "bitwarden" | "drawio" | "1password" | "discord" | "telegram" | "brave" | "amberol" | "dropbox" | "drawio" | "foliate" | "onlyoffice" | "spotify" | "parabolic" | "planify" | "todoist" | "zoom") INSTALLER_FILE="$OMORA_PATH/install/desktop/optional/app-$INSTALLER.sh" ;;
	"ollama") INSTALLER_FILE="$OMORA_PATH/install/terminal/optional/app-ollama.sh" ;;
	*) INSTALLER_FILE="$OMORA_PATH/install/terminal/app-$INSTALLER.sh" ;;
	esac

	source $INSTALLER_FILE && gum spin --spinner meter --title "Update completed!" -- sleep 3
fi

clear
source $OMORA_PATH/bin/omora
