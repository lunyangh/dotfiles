#!/bin/bash
set -e

echo "================================================="
echo "Antigravity Single Conversation Test Migration"
echo "Target: D2L Study Notes"
echo "Conversation ID: 04ea6e69-f1e6-498c-8464-2765327adf7d"
echo "Project Name:    d2l_study"
echo "================================================="

# 1. Detect Dropbox Path
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

OLD_USER="lunyanghuang"
NEW_USER="$(whoami)"

TARGET_CONV_ID="04ea6e69-f1e6-498c-8464-2765327adf7d"
TARGET_PROJ_ID="dc9c0815-f544-4df0-9971-79c2fbef81f2.json"

MIGRATION_CONV_SRC="$NEW_DROPBOX_PATH/computer_config/migration/antigravity/brain/$TARGET_CONV_ID"
MIGRATION_PROJ_SRC="$NEW_DROPBOX_PATH/computer_config/migration/antigravity/config/projects/$TARGET_PROJ_ID"

TARGET_CONV_DST="$HOME/.gemini/antigravity/brain/$TARGET_CONV_ID"
TARGET_PROJ_DST="$HOME/.gemini/config/projects/$TARGET_PROJ_ID"

if [ ! -d "$MIGRATION_CONV_SRC" ]; then
    echo "Error: Source conversation not found at $MIGRATION_CONV_SRC"
    exit 1
fi

echo "Source Dropbox:      $NEW_DROPBOX_PATH"
echo "Source Conversation: $MIGRATION_CONV_SRC"
echo "Source Project:      $MIGRATION_PROJ_SRC"
echo "Target Brain:        $TARGET_CONV_DST"
echo "Target Project:      $TARGET_PROJ_DST"

# 2. Create Staging Area
STAGING_DIR="/tmp/antigravity_test_d2l_staging"
rm -rf "$STAGING_DIR"
mkdir -p "$STAGING_DIR/brain" "$STAGING_DIR/projects"

echo "Copying D2L conversation to staging..."
cp -R "$MIGRATION_CONV_SRC" "$STAGING_DIR/brain/$TARGET_CONV_ID"

if [ -f "$MIGRATION_PROJ_SRC" ]; then
    echo "Copying D2L project config to staging..."
    cp "$MIGRATION_PROJ_SRC" "$STAGING_DIR/projects/$TARGET_PROJ_ID"
fi

# 3. Perform Path Translations
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
    -e "s|${OLD_USER}|${NEW_USER}|g" \
    {} +

# 4. Backup Existing (if any) and Install
BACKUP_TS="$(date +%Y%m%d%H%M%S)"
if [ -d "$TARGET_CONV_DST" ]; then
    echo "Backing up existing conversation to ${TARGET_CONV_DST}_backup_${BACKUP_TS}..."
    cp -R "$TARGET_CONV_DST" "${TARGET_CONV_DST}_backup_${BACKUP_TS}"
fi

if [ -f "$TARGET_PROJ_DST" ]; then
    echo "Backing up existing project config to ${TARGET_PROJ_DST}_backup_${BACKUP_TS}..."
    cp "$TARGET_PROJ_DST" "${TARGET_PROJ_DST}_backup_${BACKUP_TS}"
fi

echo "Installing migrated files into ~/.gemini..."
mkdir -p "$HOME/.gemini/antigravity/brain"
mkdir -p "$HOME/.gemini/config/projects"
mkdir -p "$HOME/.gemini/antigravity/conversations"

cp -R "$STAGING_DIR/brain/$TARGET_CONV_ID" "$HOME/.gemini/antigravity/brain/"

if [ -f "$STAGING_DIR/projects/$TARGET_PROJ_ID" ]; then
    cp "$STAGING_DIR/projects/$TARGET_PROJ_ID" "$TARGET_PROJ_DST"
fi

# Copy conversation SQLite database if present
CONV_DB_NAME="${TARGET_CONV_ID}.db"
SRC_DB="$NEW_DROPBOX_PATH/computer_config/migration/antigravity/conversations/$CONV_DB_NAME"
if [ -f "$SRC_DB" ]; then
    echo "Installing conversation database $CONV_DB_NAME into ~/.gemini/antigravity/conversations/..."
    cp "$SRC_DB" "$HOME/.gemini/antigravity/conversations/$CONV_DB_NAME"
    echo "✅ Conversation database installed."
else
    echo "Notice: $SRC_DB not found yet. Awaiting sync from 2019 Mac."
fi

# 5. Clean up Staging Area
echo "Cleaning up staging area..."
rm -rf "$STAGING_DIR"

echo "================================================="
echo "✅ Test Migration of D2L Conversation Complete!"
echo "Conversation ID: $TARGET_CONV_ID"
echo "Project:         d2l_study"
echo "Destination:     $TARGET_CONV_DST"
echo ""
echo "Next steps:"
echo "1. Relaunch Antigravity IDE."
echo "2. Look for project 'd2l_study' and conversation '$TARGET_CONV_ID'."
