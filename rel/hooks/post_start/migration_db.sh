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
bin/postit command Elixir.Postit.ReleaseTasks migrate
echo "Migrations run successfully"