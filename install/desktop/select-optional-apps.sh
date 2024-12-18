if [[ -v OMORA_FIRST_RUN_OPTIONAL_APPS ]]; then
	apps=$OMORA_FIRST_RUN_OPTIONAL_APPS

	if [[ -n "$apps" ]]; then
		for app in $apps; do
			source "$OMORA_PATH/install/desktop/optional/app-${app,,}.sh"
		done
	fi
fi
