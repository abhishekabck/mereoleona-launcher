# Mereoleona Launcher

A GNOME Shell extension that puts a quick launcher in your top bar. Run scripts, open projects, start dev servers — one click or keypress away.

**Compatible with:** GNOME Shell 45, 46, 47, 48, 49, 50, 51, 52  
**Ubuntu versions:** 23.10, 24.04, 24.10, 25.04, 25.10 and beyond

---

## Features

- **⚡ Panel button** — click to open the launcher overlay
- **Live search** — type to filter entries instantly
- **Run any command** — shell commands, scripts, app launchers
- **Add entries from UI** — `+` button opens an inline form (no config editing needed)
- **Keyboard nav** — `↑ ↓` to move, `Enter` to run, `Esc` to close
- **Config lives outside the extension** — updating the extension never wipes your entries

---

## Install

### One-liner (recommended)

```bash
git clone https://github.com/abhishekabck/mereoleona-launcher.git
cd mereoleona-launcher
bash install.sh
```

Then **log out and log back in**. The ⚡ icon appears in your top bar.

### Manual

```bash
UUID="mereoleona-launcher@mereoleona"
DEST="$HOME/.local/share/gnome-shell/extensions/$UUID"
mkdir -p "$DEST"
cp extension.js metadata.json stylesheet.css "$DEST/"
gnome-extensions enable "$UUID"
# Log out and back in
```

---

## Update

```bash
cd mereoleona-launcher
git pull
bash install.sh
# Log out and back in
```

---

## Uninstall

```bash
cd mereoleona-launcher
bash uninstall.sh
# Log out and back in
```

---

## Configuration

Entries are stored in:
```
~/.config/mereoleona-launcher/entries.json
```

You can edit it directly or use the `+` button in the launcher UI.

### Format

```json
[
  { "key": "Rise Dev",    "script": "code ~/Projects/Rise",         "icon": "🔥" },
  { "key": "Dev Server",  "script": "kitty --directory ~/Projects sh -c 'pnpm dev'", "icon": "⚡" },
  { "key": "VPN",         "script": "~/scripts/vpn-connect.sh",     "icon": "🔒" }
]
```

| Field    | Required | Description |
|----------|----------|-------------|
| `key`    | yes      | Display name shown in the launcher |
| `script` | yes      | Any shell command — supports `~/` expansion |
| `icon`   | no       | Emoji icon (defaults to `▶`) |

`script` can be:
- A shell command: `code ~/Projects/Rise`
- A script path: `~/scripts/my-script.sh`
- Anything bash understands: `docker-compose up -d`

Changes to `entries.json` take effect the next time you open the launcher — no restart needed.

---

## Keyboard shortcuts

| Key      | Action |
|----------|--------|
| `↑` `↓`  | Navigate entries |
| `Enter`  | Run selected entry |
| `Esc`    | Close launcher (or go back from add form) |
| Type anything | Filter entries |

---

## Styling

Edit `stylesheet.css` inside the extension directory to customise colours, fonts, sizes. The file is commented with every class name.

After editing CSS, reload with:
```bash
gnome-extensions disable mereoleona-launcher@mereoleona
gnome-extensions enable mereoleona-launcher@mereoleona
```
*(CSS changes reload without a full logout — only JS changes require a logout.)*

---

## Troubleshooting

**Extension shows "OUT OF DATE"**  
Your GNOME Shell version isn't in `metadata.json`. Run:
```bash
gnome-shell --version  # note the version number
```
Then add it to the `shell-version` array in `metadata.json` and re-run `bash install.sh`.

**Clicking Run does nothing**  
Check if your command works in a terminal first. Then open `/tmp/mereo-launcher.log` (if present) for debug output.

**Extension not visible after install**  
Make sure you logged out and back in — GNOME Shell caches extension metadata and JS modules on startup.
