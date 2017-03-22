#!/usr/bin/env bash
set -euo pipefail

# run the secrets_to_env script with a list of environment variables to work on

/usr/lib/bin/secrets_to_env.sh POSTGRES_PASSWORD
