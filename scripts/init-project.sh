#!/bin/bash
set -e

PROJECT_NAME=$(basename "$PWD")
MODULE_NAME="github.com/dmmoody/$PROJECT_NAME"

echo "🔧 Setting Go module to $MODULE_NAME"
go mod edit -module "$MODULE_NAME"
go mod tidy

# Ensure .envrc exists
if [ ! -f .envrc ]; then
  cp .envrc.example .envrc
fi

# Set APP_NAME
if grep -q '^export APP_NAME=' .envrc; then
  sed -i '' "s/^export APP_NAME=.*/export APP_NAME=$PROJECT_NAME/" .envrc
else
  echo "export APP_NAME=$PROJECT_NAME" >> .envrc
fi

# Set GO_VERSION
GO_VERSION=$(go version | awk '{print $3}' | sed 's/go//')
if grep -q '^export GO_VERSION=' .envrc; then
  sed -i '' "s/^export GO_VERSION=.*/export GO_VERSION=$GO_VERSION/" .envrc
else
  echo "export GO_VERSION=$GO_VERSION" >> .envrc
fi

# Update Makefile
if grep -q '^BINARY_NAME *=' Makefile; then
  sed -i '' "s/^BINARY_NAME *=.*/BINARY_NAME := $PROJECT_NAME/" Makefile
else
  echo "BINARY_NAME := $PROJECT_NAME" >> Makefile
fi

if grep -q '^GO_VERSION *=' Makefile; then
  sed -i '' "s/^GO_VERSION *=.*/GO_VERSION := $GO_VERSION/" Makefile
else
  echo "GO_VERSION := $GO_VERSION" >> Makefile
fi

# Reset Git
echo "🔧 Resetting Git"
rm -rf .git
git init
git add .
git commit -m "Initial commit from go-blueprint scaffold"

echo "🧹 Cleaning up"
rm -- "$0"

echo "✅ Project '$PROJECT_NAME' initialized with Go $GO_VERSION and binary '$PROJECT_NAME'"