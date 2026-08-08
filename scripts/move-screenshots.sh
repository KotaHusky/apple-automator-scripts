#!/bin/zsh
# Moves files whose names start with "Screenshot" from ~/Desktop into ~/Screenshots/.
set -euo pipefail

DEST="$HOME/Screenshots"
mkdir -p "$DEST"

setopt nullglob
files=("$HOME/Desktop/Screenshot"*)

if [[ ${#files[@]} -eq 0 ]]; then
  echo "No screenshot files found on Desktop."
  exit 0
fi

mv -n "${files[@]}" "$DEST/"
echo "Done. ${#files[@]} file(s) moved to $DEST"
