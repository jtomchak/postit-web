#!/usr/bin/env bash

set +e

while true; do
  nodetool ping
  EXIT_CODE=$?
  if [[ ${EXIT_CODE} -eq 0 ]]; then
    echo "Application is up! (Post Start)"
    break
  fi
done

set -e

echo "Running migrations ..."
release_ctl eval --mfa "Postit.ReleaseTasks.migrate/1" --argv -- "$@"


echo "Migrations run successfully"