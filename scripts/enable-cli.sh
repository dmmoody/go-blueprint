#!/bin/bash
set -e

DRY_RUN=false
if [[ "$1" == "--dry-run" ]]; then
  DRY_RUN=true
  echo "🔍 Dry run enabled — no changes will be made."
fi

echo "🔧 Enabling CLI module..."

if [ "$DRY_RUN" = false ]; then
  mkdir -p internal/cli
  cp -r templates/cli/* internal/cli/
fi

MAIN="cmd/app/main.go"
IMPORT_LINE='"github.com/dmmoody/go-blueprint/internal/cli"'

if ! grep -q "$IMPORT_LINE" "$MAIN"; then
  echo "🔧 Adding CLI import to $MAIN..."
  if [ "$DRY_RUN" = false ]; then
    sed -i '' "/import (/a\\
    $IMPORT_LINE
    " "$MAIN"
  fi
fi

if grep -q 'server.Start()' "$MAIN"; then
  echo "🔧 Injecting CLI handler switch into $MAIN..."
  if [ "$DRY_RUN" = false ]; then
    sed -i '' 's/server.Start()/\
if os.Getenv("APP_MODE") == "cli" {\n\t\tcli.Run()\n\t} else {\n\t\tserver.Start()\n\t}/' "$MAIN"
  fi
  echo "✅ CLI mode wired into main.go using APP_MODE"
else
  echo "⚠️ Could not inject cli.Run() automatically. Add this manually in main():"
  echo '    if os.Getenv("APP_MODE") == "cli" {'
  echo '        cli.Run()'
  echo '        return'
  echo '    }'
fi

echo "✅ CLI module $( [ "$DRY_RUN" = true ] && echo 'would be' || echo 'is' ) enabled"
echo "➡️ Set APP_MODE=cli in your .envrc"
[ "$DRY_RUN" = false ] && rm -- "$0"