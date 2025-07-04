#!/bin/bash
set -e

DRY_RUN=false
if [[ "$1" == "--dry-run" ]]; then
  DRY_RUN=true
  echo "🔍 Dry run enabled — no changes will be made."
fi

echo "🔧 Enabling Pub/Sub module..."

if [ "$DRY_RUN" = false ]; then
  mkdir -p internal/pubsub
  cp -r templates/pubsub/* internal/pubsub/
fi

MAIN="cmd/app/main.go"
IMPORT_LINE='"github.com/dmmoody/go-blueprint/internal/pubsub"'

if ! grep -q "$IMPORT_LINE" "$MAIN"; then
  echo "🔧 Adding Pub/Sub import to $MAIN..."
  [ "$DRY_RUN" = false ] && sed -i '' "/import (/a\\
    $IMPORT_LINE
  " "$MAIN"
fi

echo "➡️ Add this to internal/server/server.go:"
echo '    go pubsub.StartConsumer(ctx)'

echo "✅ Pub/Sub module $( [ "$DRY_RUN" = true ] && echo 'would be' || echo 'is' ) scaffolded"
[ "$DRY_RUN" = false ] && rm -- "$0"