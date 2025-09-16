#!/usr/bin/env bash
set -euo pipefail

# Paths
DEV_JS_TMP="/tmp/worker.dev.js"

echo "🧹 Cleaning old outputs..."
rm -f web/worker.dart.js web/worker.dart.min.js
rm -rf build .dart_tool/build
rm -f "$DEV_JS_TMP"

echo "🚧 Building unminified (dev) worker..."
dart run build_runner build --delete-conflicting-outputs -o web:build/web/
if [[ ! -f build/web/worker.dart.js ]]; then
  echo "❌ Dev build failed: build/web/worker.dart.js not found"
  exit 1
fi
cp build/web/worker.dart.js "$DEV_JS_TMP"
echo "✅ Saved dev build to $DEV_JS_TMP"

echo "🚀 Building minified (release) worker..."
dart run build_runner build --release --delete-conflicting-outputs -o web:build/web/
if [[ ! -f build/web/worker.dart.js ]]; then
  echo "❌ Release build failed: build/web/worker.dart.js not found"
  exit 1
fi
cp build/web/worker.dart.js web/worker.dart.min.js
echo "✅ Minified worker saved to web/worker.dart.min.js"

echo "♻️ Restoring unminified worker..."
cp "$DEV_JS_TMP" web/worker.dart.js
echo "✅ Unminified worker restored to web/worker.dart.js"

echo "🧽 Cleaning temp files..."
rm -f "$DEV_JS_TMP"
rm -rf build/web

echo "🎉 Done! Both web/worker.dart.js and web/worker.dart.min.js are ready."