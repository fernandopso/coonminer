#!/bin/bash
set -e

if [ -f /coonminer/tmp/pids/server.pid ]; then
  rm /coonminer/tmp/pids/server.pid
fi

rake db:create
rake db:migrate

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
