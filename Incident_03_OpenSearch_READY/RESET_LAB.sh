#!/bin/sh
set -eu
cd "$(dirname "$0")"
echo "This removes the lab data volume."
printf "Type RESET to continue: "
read ans
[ "$ans" = "RESET" ] || exit 0
docker compose down -v
echo "Reset complete. Run ./START_LAB.sh to recreate."
