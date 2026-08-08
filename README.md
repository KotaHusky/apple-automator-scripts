# apple-automator-scripts

macOS automation scripts and Automator Folder Action workflows.

## One-click install

```bash
bash install.sh
```

Copies every workflow in `workflows/` to `~/Library/Workflows/Applications/Folder Actions/` and attaches each one to its configured folder via AppleScript. If macOS prompts for Automation access, click **Allow**.

## Workflows

| Workflow | Trigger | Description |
|----------|---------|-------------|
| `move-screenshots.workflow` | Files added to Desktop | Moves `Screenshot*` files from Desktop into `~/Screenshots/` |

## Standalone scripts

Each workflow also has a plain shell script equivalent in `scripts/` for running directly from the terminal:

```bash
bash scripts/move-screenshots.sh
```

## Adding a new workflow

1. Create your Folder Action in Automator and save it as a `.workflow` file
2. Copy the bundle into `workflows/`
3. Set `folderActionFolderPath` in `document.wflow` → `workflowMetaData` to your target folder (e.g. `~/Desktop`)
4. Run `bash install.sh` — it picks up all workflows automatically
