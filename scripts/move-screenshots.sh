#!/usr/bin/env bash
# Moves files whose names start with "Screenshot" from ~/Desktop into ~/Screenshots/.
set -euo pipefail

DEST="$HOME/Screenshots"
mkdir -p "$DEST"

shopt -s nullglob
files=("$HOME/Desktop/Screenshot"*)

if [[ ${#files[@]} -eq 0 ]]; then
  echo "No screenshot files found on Desktop."
  exit 0
fi

for f in "${files[@]}"; do
  mv -n "$f" "$DEST/"
  echo "Moved: $(basename "$f")"
done

echo "Done. ${#files[@]} file(s) moved to $DEST"
