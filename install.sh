#!/usr/bin/env bash
set -e

UUID="mereoleona-launcher@mereoleona"
INSTALL_DIR="$HOME/.local/share/gnome-shell/extensions/$UUID"
CONFIG_DIR="$HOME/.config/mereoleona-launcher"

echo "Installing Mereoleona Launcher..."

# Check GNOME Shell version
GNOME_VERSION=$(gnome-shell --version 2>/dev/null | grep -oP '\d+' | head -1)
if [[ -z "$GNOME_VERSION" ]]; then
    echo "Warning: Could not detect GNOME Shell version. Proceeding anyway."
elif [[ "$GNOME_VERSION" -lt 45 ]]; then
    echo "Error: GNOME Shell 45+ required (found $GNOME_VERSION). This extension uses ES modules."
    exit 1
else
    echo "  GNOME Shell $GNOME_VERSION detected — compatible."
fi

# Install extension files
mkdir -p "$INSTALL_DIR"
cp extension.js metadata.json stylesheet.css "$INSTALL_DIR/"
echo "  Extension files copied to $INSTALL_DIR"

# Create default config if it doesn't exist
if [[ ! -f "$CONFIG_DIR/entries.json" ]]; then
    mkdir -p "$CONFIG_DIR"
    cat > "$CONFIG_DIR/entries.json" << 'EOF'
[
  { "key": "Terminal",  "script": "kitty",             "icon": "🖥️" },
  { "key": "Files",     "script": "nautilus ~",        "icon": "📁" },
  { "key": "Editor",    "script": "code ~",             "icon": "✏️" }
]
EOF
    echo "  Default config created at $CONFIG_DIR/entries.json"
else
    echo "  Config already exists — not overwriting."
fi

# Enable the extension
if command -v gnome-extensions &>/dev/null; then
    gnome-extensions enable "$UUID" 2>/dev/null && echo "  Extension enabled." || echo "  Could not enable — enable manually after relogging."
fi

echo ""
echo "Done! Log out and log back in to activate the extension."
echo "The ⚡ icon will appear in your top bar."
echo ""
echo "Config: $CONFIG_DIR/entries.json"
