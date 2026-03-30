#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

FLUTTER_SDK="${FLUTTER_SDK:-$ROOT/.flutter}"

if [ ! -x "$FLUTTER_SDK/bin/flutter" ]; then
  echo "Cloning Flutter stable (one-time per build machine)..."
  rm -rf "$FLUTTER_SDK"
  git clone https://github.com/flutter/flutter.git -b stable --depth 1 "$FLUTTER_SDK"
fi

export PATH="$FLUTTER_SDK/bin:$PATH"

flutter config --no-analytics
flutter precache --web
flutter pub get
flutter build web --release
