#!/bin/bash
set -e

echo "================================================="
echo "Antigravity Brain Migration Script"
echo "================================================="

# 1. Warn user
echo "WARNING: Please ensure you have closed the Antigravity IDE and stopped the AGY daemon before proceeding."
read -p "Press Enter to continue or Ctrl+C to abort..."

# 2. Path Mappings
OLD_USER="lunyanghuang"
NEW_USER="$(whoami)"

# Detect Dropbox Path on New Machine
if [ -d "$HOME/files/Dropbox" ]; then
    NEW_DROPBOX_PATH="$HOME/files/Dropbox"
elif [ -d "$HOME/Library/CloudStorage/Dropbox" ]; then
    NEW_DROPBOX_PATH="$HOME/Library/CloudStorage/Dropbox"
elif [ -d "$HOME/Dropbox" ]; then
    NEW_DROPBOX_PATH="$HOME/Dropbox"
else
    echo "Error: Dropbox folder not found in $HOME/files/Dropbox, ~/Library/CloudStorage/Dropbox, or ~/Dropbox."
    exit 1
fi

MIGRATION_SOURCE="$NEW_DROPBOX_PATH/computer_config/migration/antigravity/brain"
MIGRATION_CONFIG="$NEW_DROPBOX_PATH/computer_config/migration/antigravity/config"
MIGRATION_CONVERSATIONS="$NEW_DROPBOX_PATH/computer_config/migration/antigravity/conversations"
TARGET_DESTINATION="$HOME/.gemini/antigravity/brain"
CONFIG_DESTINATION="$HOME/.gemini/config"
TARGET_CONVERSATIONS="$HOME/.gemini/antigravity/conversations"

if [ ! -d "$MIGRATION_SOURCE" ]; then
    echo "Error: Migration source not found at $MIGRATION_SOURCE"
    exit 1
fi

echo "Source Dropbox:       $NEW_DROPBOX_PATH"
echo "Target Brain:         $TARGET_DESTINATION"
echo "Target Config:        $CONFIG_DESTINATION"
echo "Target Conversations: $TARGET_CONVERSATIONS"

# 3. Create a temporary staging area
STAGING_DIR="/tmp/antigravity_brain_migration_staging"
rm -rf "$STAGING_DIR"
mkdir -p "$STAGING_DIR"

echo "Copying brain and config to staging area..."
cp -R "$MIGRATION_SOURCE" "$STAGING_DIR/brain"
if [ -d "$MIGRATION_CONFIG" ]; then
    cp -R "$MIGRATION_CONFIG" "$STAGING_DIR/config"
fi

# 4. Perform Path Translation
echo "Translating paths from old format to new format..."
export LC_ALL=C

find "$STAGING_DIR" -type f \( \
    -name "*.json" -o \
    -name "*.jsonl" -o \
    -name "*.md" -o \
    -name "*.yaml" -o \
    -name "*.yml" -o \
    -name "*.py" -o \
    -name "*.sh" -o \
    -name "*.txt" -o \
    -name "*.toml" \
\) -exec sed -i '' \
    -e "s|/Users/${OLD_USER}/Dropbox%20%28Personal%29|${NEW_DROPBOX_PATH}|g" \
    -e "s|/Users/${OLD_USER}/Dropbox (Personal)|${NEW_DROPBOX_PATH}|g" \
    -e "s|/Users/${OLD_USER}/Dropbox|${NEW_DROPBOX_PATH}|g" \
    -e "s|/Users/${OLD_USER}|${HOME}|g" \
    {} +

# 5. Backup and Merge into App Data Directory
BACKUP_TS="$(date +%Y%m%d%H%M%S)"
echo "Backing up any existing brain and config..."
if [ -d "$TARGET_DESTINATION" ]; then
    echo "Backing up brain to ${TARGET_DESTINATION}_backup_${BACKUP_TS}..."
    cp -R "$TARGET_DESTINATION" "${TARGET_DESTINATION}_backup_${BACKUP_TS}"
fi
if [ -d "$CONFIG_DESTINATION" ]; then
    echo "Backing up config to ${CONFIG_DESTINATION}_backup_${BACKUP_TS}..."
    cp -R "$CONFIG_DESTINATION" "${CONFIG_DESTINATION}_backup_${BACKUP_TS}"
fi

echo "Moving translated brain and config into place..."
mkdir -p "$TARGET_DESTINATION"
mkdir -p "$CONFIG_DESTINATION"
mkdir -p "$TARGET_CONVERSATIONS"

cp -R "$STAGING_DIR/brain/." "$TARGET_DESTINATION/"
if [ -d "$STAGING_DIR/config" ]; then
    cp -R "$STAGING_DIR/config/." "$CONFIG_DESTINATION/"
fi
if [ -d "$MIGRATION_CONVERSATIONS" ]; then
    echo "Copying conversation databases into place..."
    cp -R "$MIGRATION_CONVERSATIONS/." "$TARGET_CONVERSATIONS/"
fi

echo "Cleaning up staging area..."
rm -rf "$STAGING_DIR"

echo "================================================="
echo "✅ Antigravity Migration Complete!"
echo "You may now start the Antigravity agent on your new Mac."
