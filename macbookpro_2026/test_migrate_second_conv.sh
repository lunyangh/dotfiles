#!/bin/bash
set -e

echo "================================================="
echo "Antigravity Second Conversation Test Migration"
echo "Target: D2L Early Stopping & Model Checkpointing"
echo "Conversation ID: b5e2371e-8662-4456-9abb-329aac8420c1"
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
    echo "Error: Dropbox folder not found."
    exit 1
fi

OLD_USER="lunyanghuang"
NEW_USER="$(whoami)"

TARGET_CONV_ID="b5e2371e-8662-4456-9abb-329aac8420c1"
TARGET_PROJ_ID="dc9c0815-f544-4df0-9971-79c2fbef81f2.json"
TARGET_CONV_DB="${TARGET_CONV_ID}.db"

MIGRATION_CONV_SRC="$NEW_DROPBOX_PATH/computer_config/migration/antigravity/brain/$TARGET_CONV_ID"
MIGRATION_DB_SRC="$NEW_DROPBOX_PATH/computer_config/migration/antigravity/conversations/$TARGET_CONV_DB"
MIGRATION_PROJ_SRC="$NEW_DROPBOX_PATH/computer_config/migration/antigravity/config/projects/$TARGET_PROJ_ID"

TARGET_CONV_DST="$HOME/.gemini/antigravity/brain/$TARGET_CONV_ID"
TARGET_DB_DST="$HOME/.gemini/antigravity/conversations/$TARGET_CONV_DB"
TARGET_PROJ_DST="$HOME/.gemini/config/projects/$TARGET_PROJ_ID"

if [ ! -d "$MIGRATION_CONV_SRC" ]; then
    echo "Error: Source conversation not found at $MIGRATION_CONV_SRC"
    exit 1
fi
if [ ! -f "$MIGRATION_DB_SRC" ]; then
    echo "Error: Source conversation database not found at $MIGRATION_DB_SRC"
    exit 1
fi

echo "Source Brain:         $MIGRATION_CONV_SRC"
echo "Source Database:      $MIGRATION_DB_SRC"
echo "Target Brain:         $TARGET_CONV_DST"
echo "Target Database:      $TARGET_DB_DST"

# 2. Create Staging Area for Path Translation
STAGING_DIR="/tmp/antigravity_test_second_staging"
rm -rf "$STAGING_DIR"
mkdir -p "$STAGING_DIR/brain" "$STAGING_DIR/projects"

echo "Copying conversation brain to staging area..."
cp -R "$MIGRATION_CONV_SRC" "$STAGING_DIR/brain/$TARGET_CONV_ID"

if [ -f "$MIGRATION_PROJ_SRC" ]; then
    cp "$MIGRATION_PROJ_SRC" "$STAGING_DIR/projects/$TARGET_PROJ_ID"
fi

# 3. Perform Path Translations
echo "Translating paths in text logs and artifacts..."
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
if [ -f "$TARGET_DB_DST" ]; then
    echo "Backing up existing DB to ${TARGET_DB_DST}_backup_${BACKUP_TS}..."
    cp "$TARGET_DB_DST" "${TARGET_DB_DST}_backup_${BACKUP_TS}"
fi

echo "Installing migrated files into ~/.gemini..."
mkdir -p "$HOME/.gemini/antigravity/brain"
mkdir -p "$HOME/.gemini/antigravity/conversations"
mkdir -p "$HOME/.gemini/config/projects"

# Install Brain
cp -R "$STAGING_DIR/brain/$TARGET_CONV_ID" "$HOME/.gemini/antigravity/brain/"

# Install Database
cp "$MIGRATION_DB_SRC" "$TARGET_DB_DST"

# Install Project Config (if not already present)
if [ ! -f "$TARGET_PROJ_DST" ] && [ -f "$STAGING_DIR/projects/$TARGET_PROJ_ID" ]; then
    cp "$STAGING_DIR/projects/$TARGET_PROJ_ID" "$TARGET_PROJ_DST"
fi

# 5. Clean up Staging Area
echo "Cleaning up staging area..."
rm -rf "$STAGING_DIR"

echo "================================================="
echo "✅ Test Migration of Second Conversation Complete!"
echo "Conversation ID: $TARGET_CONV_ID"
echo "Topic:           D2L Early Stopping & Checkpointing"
echo "Database:        $TARGET_DB_DST"
echo "Brain:           $TARGET_CONV_DST"
echo "================================================="
