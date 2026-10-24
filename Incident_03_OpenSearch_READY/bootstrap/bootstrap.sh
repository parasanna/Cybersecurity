#!/bin/sh
set -eu
OS="http://opensearch:9200"
DASH="http://dashboards:5601"
EVENT_INDEX="cyberlab-incident03-lite"
ALERT_INDEX="cyberlab-incident03-alerts-lite"
EVENT_VIEW="incident-03-events"
ALERT_VIEW="incident-03-alerts"

echo "Waiting for OpenSearch..."
until curl -fsS "$OS" >/dev/null 2>&1; do sleep 3; done
echo "Waiting for OpenSearch Dashboards..."
until curl -fsS "$DASH/api/status" >/dev/null 2>&1; do sleep 3; done

# Create the indexes only if they do not already exist.
if ! curl -fsS "$OS/$EVENT_INDEX" >/dev/null 2>&1; then
  curl -fsS -X PUT "$OS/$EVENT_INDEX" -H 'Content-Type: application/json' --data-binary @/bootstrap/event_mapping.json >/dev/null
  R=$(curl -fsS -X POST "$OS/_bulk?refresh=true&filter_path=errors" -H 'Content-Type: application/x-ndjson' --data-binary @/data/events_bulk.ndjson)
  echo "$R" | grep -q '"errors":false' || { echo "Event import reported errors: $R"; exit 1; }
fi
if ! curl -fsS "$OS/$ALERT_INDEX" >/dev/null 2>&1; then
  curl -fsS -X PUT "$OS/$ALERT_INDEX" -H 'Content-Type: application/json' --data-binary @/bootstrap/alert_mapping.json >/dev/null
  R=$(curl -fsS -X POST "$OS/_bulk?refresh=true&filter_path=errors" -H 'Content-Type: application/x-ndjson' --data-binary @/data/alerts_bulk.ndjson)
  echo "$R" | grep -q '"errors":false' || { echo "Alert import reported errors: $R"; exit 1; }
fi

# Create ready-to-use data views (index patterns) in Dashboards.
curl -fsS -X POST "$DASH/api/saved_objects/index-pattern/$EVENT_VIEW?overwrite=true" \
  -H 'osd-xsrf: true' -H 'Content-Type: application/json' \
  -d '{"attributes":{"title":"'$EVENT_INDEX'","timeFieldName":"timestamp"}}' >/dev/null
curl -fsS -X POST "$DASH/api/saved_objects/index-pattern/$ALERT_VIEW?overwrite=true" \
  -H 'osd-xsrf: true' -H 'Content-Type: application/json' \
  -d '{"attributes":{"title":"'$ALERT_INDEX'","timeFieldName":"timestamp"}}' >/dev/null

echo "OpenSearch lab Incident 03 is ready."
