# Install default databases
AVAILABLE_DBS=("MySQL" "Redis" "PostgreSQL")
dbs=$(gum choose "${AVAILABLE_DBS[@]}" --no-limit --height 5 --header "Select databases (runs in Docker)")

function installDevStorages(){
	local dbsSelected=("$@")
	if [[ -n "$dbsSelected" ]]; then
		for db in "${dbsSelected[@]}"; do
			case $db in
			MySQL)
				sudo docker run -d --restart unless-stopped -p "127.0.0.1:3306:3306" --name=mysql8 -e MYSQL_ROOT_PASSWORD= -e MYSQL_ALLOW_EMPTY_PASSWORD=true mysql:8.4
				;;
			Redis)
				sudo docker run -d --restart unless-stopped -p "127.0.0.1:6379:6379" --name=redis redis:7
				;;
			PostgreSQL)
				sudo docker run -d --restart unless-stopped -p "127.0.0.1:5432:5432" --name=postgres16 -e POSTGRES_HOST_AUTH_METHOD=trust postgres:16
				;;
			esac
		done
	fi
}

export -f installDevStorages
gum spin --show-error --title "Installing selected development storages (runs in Docker)..." -- bash -c "installDevStorages \"$dbs\""
unset -f installDevStorages
