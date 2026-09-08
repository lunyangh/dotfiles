#!/bin/bash
set -e

echo "================================================="
echo "Move Outside-of-Project Conversations to 'chat'"
echo "================================================="

# 1. Check if Antigravity is running
if pgrep -i "antigravity" > /dev/null 2>&1; then
    echo "WARNING: Antigravity appears to be currently running."
    echo "Please completely quit Antigravity (Cmd+Q) before running this script,"
    echo "so that SQLite database locks are released and cached state is refreshed."
    echo ""
    read -p "Once Antigravity is closed, press Enter to continue (or Ctrl+C to abort)..."
fi

# 2. Target Directory
TARGET_DIR="$HOME/.gemini/antigravity/conversations"

# Target: project "chat" ID
CHAT_PROJECT_ID="a2f3e0d2-26dd-4a90-9e54-14e2896787d2"

# Hex patterns for protobuf field 18:
# "outside-of-project" -> 9201 (tag 18, wire 2) + 12 (len 18) + 6f7574736964652d6f662d70726f6a656374
OLD_HEX="9201126F7574736964652D6F662D70726F6A656374"
# chat project ID -> 9201 (tag 18, wire 2) + 24 (len 36) + 61326633653064322d323664642d346139302d396535342d313465323839363738376432
NEW_HEX="92012461326633653064322D323664642D346139302D396535342D313465323839363738376432"

CONVERSATIONS=(
    "468f6e7a-e507-4257-9adb-03701de5a44c"  # Two Sigma non-compete
    "58653aab-4468-4821-923a-ba7c1957f534"  # 2026 MacBook series news
    "66138312-0180-42b3-b04d-0edf0b4c6465"  # Antigravity chat privacy
    "fdcba886-12f9-4999-ae58-94cdd7250184"  # H1B renew paper I-94
)

update_db() {
    local db_path="$1"
    local cid="$2"

    if [ ! -f "$db_path" ]; then
        echo "  [SKIP] Not found: $db_path"
        return
    fi

    # Backup
    cp "$db_path" "${db_path}.bak"

    # SQLite UPDATE
    sqlite3 "$db_path" "UPDATE trajectory_metadata_blob SET data = unhex(replace(hex(data), '$OLD_HEX', '$NEW_HEX'));"

    # Verify
    if strings "$db_path" | grep -q "$CHAT_PROJECT_ID"; then
        echo "  [OK] $cid -> Updated to 'chat' project ($CHAT_PROJECT_ID)"
    else
        echo "  [FAIL] $cid -> Update failed verification."
    fi
}

echo ""
echo "--- Updating live databases in $TARGET_DIR ---"
for cid in "${CONVERSATIONS[@]}"; do
    db_file="$TARGET_DIR/${cid}.db"
    update_db "$db_file" "$cid"
done

echo ""
echo "================================================="
echo "Done! You can now relaunch Antigravity."
echo "The 4 conversations will appear under the 'chat' project."
echo "================================================="
