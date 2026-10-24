#!/bin/sh
set -eu
cd "$(dirname "$0")"
docker compose down
echo "Lab stopped. Data volume preserved."
