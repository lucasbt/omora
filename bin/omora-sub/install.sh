CHOICES=(
	"Dev Language  Install programming language environment"
	"Dev Database  Install development database in Docker"
	"Bitwarden     Best OSS app for manage your passwords securely across devices"
	"1Password     Best Commercial app for manage your passwords securely across devices"
	"Discord       Messaging, voice and video client"
	"Telegram      Messaging app with a focus on security and speed"
	"Brave         Chrome-based browser with built-in ad blocking"
	"Amberol       Plays music, and nothing else"
	"Dropbox       Sync files across computers with ease"
	"Draw.io       Diagramming tool"
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
	"> All         Re-run any of the default installers"
	"<< Back       "
)

CHOICE=$(gum choose "${CHOICES[@]}" --height 19 --header "Install application(s)")

if [[ "$CHOICE" == "<< Back"* ]] || [[ -z "$CHOICE" ]]; then
	# Don't install anything
	echo ""
elif [[ "$CHOICE" == "> All"* ]]; then
	INSTALLER_FILE=$(gum file $OMORA_PATH/install)

	[[ -n "$INSTALLER_FILE" ]] &&
		gum confirm "Run installer?" &&
		source $INSTALLER_FILE > /dev/null 2>&1
else
	INSTALLER=$(echo "$CHOICE" | awk -F ' {2,}' '{print $1}' | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')

	case "$INSTALLER" in
	"dev-language") INSTALLER_FILE="$OMORA_PATH/install/terminal/select-dev-language.sh" ;;
	"dev-database") INSTALLER_FILE="$OMORA_PATH/install/terminal/select-dev-storage.sh" ;;
	"ollama") INSTALLER_FILE="$OMORA_PATH/install/terminal/optional/app-ollama.sh" ;;
	*) INSTALLER_FILE="$OMORA_PATH/install/desktop/optional/app-$INSTALLER.sh" ;;
	esac

	source $INSTALLER_FILE > /dev/null 2>&1
fi

gum spin --spinner meter --title "Install completed!" -- sleep 3

clear
source $OMORA_PATH/bin/omora
