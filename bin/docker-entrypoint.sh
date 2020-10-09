#!/bin/bash
set -e

echo "RUNNING DOCKER ENTRYPOINT"

if [ -z "$SD_ENV_PATH" ]; then
  echo "No SD_ENV_PATH set."
else
  if eval "$(/getS3Config)"; then
    echo
    echo 'ENV variables loaded and set from' $SD_ENV_PATH
    echo
  else
    exit 1
  fi
fi

exec "$@"
