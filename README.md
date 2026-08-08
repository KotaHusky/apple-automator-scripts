# apple-automator-scripts

Shell scripts for macOS automation, designed to run via Automator's "Run Shell Script" action or directly from the terminal.

## Scripts

| Script | Description |
|--------|-------------|
| `scripts/move-screenshots.sh` | Moves files starting with "Screenshot" from the Desktop into `~/Screenshots/` |

## Usage

Each script can be run directly:

```bash
bash scripts/move-screenshots.sh
```

Or wired into an Automator workflow:
1. Open Automator → New Document → Application (or Folder Action)
2. Add a **Run Shell Script** action
3. Paste the script contents (or call `bash /path/to/script.sh`)
