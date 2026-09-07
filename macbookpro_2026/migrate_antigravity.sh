#!/bin/bash
set -e

echo "================================================="
echo "Antigravity Brain Migration Script"
echo "================================================="

# 1. Warn user
echo "WARNING: Please ensure you have closed the Antigravity IDE and stopped the AGY daemon before proceeding."
read -p "Press Enter to continue or Ctrl+C to abort..."

# 2. Paths
OLD_DROPBOX_PATH="/Users/lunyanghuang/Dropbox (Personal)"
NEW_DROPBOX_PATH="$HOME/Library/CloudStorage/Dropbox"

MIGRATION_SOURCE="$NEW_DROPBOX_PATH/computer_config/migration/antigravity/brain"
TARGET_DESTINATION="$HOME/.gemini/antigravity/brain"

if [ ! -d "$MIGRATION_SOURCE" ]; then
    echo "Error: Migration source not found at $MIGRATION_SOURCE"
    exit 1
fi

# 3. Create a temporary staging area
STAGING_DIR="/tmp/antigravity_brain_migration_staging"
rm -rf "$STAGING_DIR"
mkdir -p "$STAGING_DIR"

echo "Copying brain and config to staging area..."
cp -R "$NEW_DROPBOX_PATH/computer_config/migration/antigravity/brain" "$STAGING_DIR/brain"
cp -R "$NEW_DROPBOX_PATH/computer_config/migration/antigravity/config" "$STAGING_DIR/config"

# 4. Perform Path Translation
echo "Translating Dropbox paths from old format to new format..."
# Find all text-based files (json, jsonl, md) and replace the paths
find "$STAGING_DIR" -type f \( -name "*.json" -o -name "*.jsonl" -o -name "*.md" -o -name "*.yaml" \) -exec sed -i '' "s|${OLD_DROPBOX_PATH}|${NEW_DROPBOX_PATH}|g" {} +

# 5. Restore to App Data Directory
echo "Backing up any existing brain and config..."
if [ -d "$TARGET_DESTINATION" ]; then
    mv "$TARGET_DESTINATION" "${TARGET_DESTINATION}_backup_$(date +%Y%m%d%H%M%S)"
fi
if [ -d "$HOME/.gemini/config" ]; then
    mv "$HOME/.gemini/config" "$HOME/.gemini/config_backup_$(date +%Y%m%d%H%M%S)"
fi

echo "Moving translated brain and config into place..."
mkdir -p "$HOME/.gemini/antigravity"
cp -R "$STAGING_DIR/brain" "$TARGET_DESTINATION"
cp -R "$STAGING_DIR/config" "$HOME/.gemini/config"

echo "Cleaning up..."
rm -rf "$STAGING_DIR"

echo "================================================="
echo "✅ Antigravity Migration Complete!"
echo "You may now start the Antigravity agent on your new Mac."
