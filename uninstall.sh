#!/usr/bin/env bash
set -e

UUID="mereoleona-launcher@mereoleona"
INSTALL_DIR="$HOME/.local/share/gnome-shell/extensions/$UUID"

echo "Uninstalling Mereoleona Launcher..."

# Disable first
if command -v gnome-extensions &>/dev/null; then
    gnome-extensions disable "$UUID" 2>/dev/null || true
fi

# Remove extension files
if [[ -d "$INSTALL_DIR" ]]; then
    rm -rf "$INSTALL_DIR"
    echo "  Extension files removed."
else
    echo "  Extension not found at $INSTALL_DIR — already uninstalled?"
fi

echo ""
echo "Done. Your config at ~/.config/mereoleona-launcher/ was kept."
echo "To also remove your entries: rm -rf ~/.config/mereoleona-launcher/"
