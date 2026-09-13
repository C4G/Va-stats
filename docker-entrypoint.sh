#!/bin/sh

# Apply committed Prisma migrations before starting the application.
set -eu

ATTEMPTS=30

log() {
  echo "[entrypoint] $*"
}

i=1
while [ "$i" -le "$ATTEMPTS" ]; do
  log "Applying Prisma migrations (attempt $i/$ATTEMPTS)..."
  if output=$(prisma migrate deploy 2>&1); then
    echo "$output"
    log "Migrations applied. Starting server..."
    exec "$@"
  fi

  echo "$output"
  case "$output" in
    *P1001*|*reach*database*|*ECONNREFUSED*)
      log "Database is not reachable yet; retrying in 2s..."
      i=$((i + 1))
      sleep 2
      ;;
    *)
      log "Migration failed with a non-connection error; aborting."
      exit 1
      ;;
  esac
done

log "Database never became reachable after $ATTEMPTS attempts; aborting."
exit 1
