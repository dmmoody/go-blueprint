#!/bin/bash
set -e

DRY_RUN=false
if [[ "$1" == "--dry-run" ]]; then
  DRY_RUN=true
  echo "🔍 Dry run enabled — no changes will be made."
fi

echo "🔧 Enabling API module..."

if [ "$DRY_RUN" = false ]; then
  mkdir -p internal/api
  cp -r templates/api/* internal/api/
fi

MAIN="cmd/app/main.go"
IMPORT_LINE='"github.com/dmmoody/go-blueprint/internal/api"'

if ! grep -q "$IMPORT_LINE" "$MAIN"; then
  echo "🔧 Adding API import to $MAIN..."
  [ "$DRY_RUN" = false ] && sed -i '' "/import (/a\\
    $IMPORT_LINE
  " "$MAIN"
fi

echo "➡️ Add this to internal/server/server.go:"
echo '    go api.Start()'

echo "✅ API module $( [ "$DRY_RUN" = true ] && echo 'would be' || echo 'is' ) scaffolded"
[ "$DRY_RUN" = false ] && rm -- "$0"