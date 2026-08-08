#!/bin/zsh
# One-command install for all automator workflows in this repo.
# Copies each .workflow bundle into ~/Library/Workflows/Applications/Folder Actions/
# and attaches it to the configured folder via AppleScript.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
FOLDER_ACTIONS_DIR="$HOME/Library/Workflows/Applications/Folder Actions"

mkdir -p "$FOLDER_ACTIONS_DIR"

install_workflow() {
  local src="$1"
  local name="$(basename "$src" .workflow)"
  local dest="$FOLDER_ACTIONS_DIR/$(basename "$src")"

  echo "Installing: $name"
  cp -Rf "$src" "$dest"

  # Read the target folder from the workflow's folderActionFolderPath key
  local folder_path
  folder_path=$(defaults read "$dest/Contents/document" workflowMetaData 2>/dev/null \
    | grep -A1 folderActionFolderPath \
    | tail -1 \
    | tr -d '";' \
    | xargs) || folder_path="$HOME/Desktop"
  folder_path="${folder_path/#\~/$HOME}"

  osascript <<APPLESCRIPT
tell application "System Events"
    set folder actions enabled to true
    set targetFolder to "$folder_path"
    set workflowPath to "$dest"
    try
        make new folder action with properties {name:"$name", path:workflowPath} at folder targetFolder
    on error
        -- already attached; just make sure it's enabled
    end try
    try
        set enabled of folder action "$name" of folder targetFolder to true
    end try
end tell
APPLESCRIPT

  echo "  Attached to: $folder_path"
}

for workflow in "$REPO_DIR"/workflows/*.workflow; do
  install_workflow "$workflow"
done

echo ""
echo "All workflows installed."
echo "If macOS prompts for Automation access, click Allow."
