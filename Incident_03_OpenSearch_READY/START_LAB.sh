#!/bin/sh
set -eu
cd "$(dirname "$0")"
if ! command -v docker >/dev/null 2>&1; then
  echo "Docker is not installed. Install Docker Desktop/Engine and retry."
  exit 1
fi
if ! docker info >/dev/null 2>&1; then
  echo "Docker is installed but not running."
  exit 1
fi
echo "Starting the Cyber Incident OpenSearch lab..."
docker compose up -d
echo "Waiting for OpenSearch Dashboards..."
i=0
until curl -fsS http://localhost:5601/api/status >/dev/null 2>&1; do
  i=$((i+1)); [ "$i" -gt 180 ] && { echo "Still starting. Open http://localhost:5601/app/discover in a minute."; exit 0; }; sleep 4
done
echo "Lab is ready: http://localhost:5601/app/discover"
