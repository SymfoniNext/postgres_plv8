#!/usr/bin/env bash
set -euo pipefail



# This script takes a list of environment variables that might be supplied as
# files as it's arguements and works over them checking if they are set
# directly or a *_FILE environment variable is set and if so attempting to read
# the file and set the environment variable.  To make this more general one
# could possibly do something clever looking for environment vars of the form
# *_FILE.

# example usage
# $ secrets_to_env PASSWORD API_KEY


# This function comes from
# https://github.com/docker-library/wordpress/blob/master/php5.6/fpm-alpine/docker-entrypoint.sh

convert_file_to_environment_var() {
	local var="$1"
	local fileVar="${var}_FILE"
	local def="${2:-}"
	if [ "${!var:-}" ] && [ "${!fileVar:-}" ]; then
		echo >&2 "error: please set either $var or $fileVar but not both"
		exit 1
	fi
	local val="$def"
	if [ "${!var:-}" ]; then
		val="${!var}"
	elif [ "${!fileVar:-}" ]; then
		val="$(< "${!fileVar}")"
	fi
	export "$var"="$val"
	unset "$fileVar"
}

# End of code requiring repo to be GPLed

envs=("$@")
for e in "${envs[@]}"; do
    convert_file_to_environment_var "$e"
done
