# Task 05: Antigravity History & Configuration Migration

**Context:** The user is migrating Antigravity agent sessions, memories, and configurations from the old 2019 MacBook Pro (`lunyanghuang`) to the new 2026 Apple Silicon MacBook Pro (`lunyang`).

---

## 1. Antigravity Architecture & Required Data Layers

Antigravity uses a **three-tier local storage architecture** located under `~/.gemini/`:

| Layer | Path | Contents & Function |
| :--- | :--- | :--- |
| **1. Brain (Artifacts & Logs)** | `~/.gemini/antigravity/brain/<id>/` | Text-based logs (`transcript.jsonl`, `transcript_full.jsonl`), plans (`implementation_plan.md`), walkthroughs (`walkthrough.md`), and scratch scripts. |
| **2. Conversations (UI & State)** | `~/.gemini/antigravity/conversations/<id>.db` | **SQLite databases** holding the UI chat payload, step states, and workspace URI bindings. **Without this `.db` file, the UI cannot list or render the chat (`conversation could not be loaded`).** |
| **3. Global Configs & Projects** | `~/.gemini/config/` | `config.json` (settings), `AGENTS.md` (global instructions), and `projects/*.json` (workspace project definitions). |

---

## 2. Test Migration Finding on Mac 2026 (Root Cause Analysis)

During testing with the **D2L study notes** conversation (`04ea6e69-f1e6-498c-8464-2765327adf7d`):
1. The project `d2l_study` appeared correctly in the Antigravity workspace list (`projects/dc9c0815-f544-4df0-9971-79c2fbef81f2.json`).
2. However, the conversation list in the UI remained empty.
3. Clicking `conversation://04ea6e69-f1e6-498c-8464-2765327adf7d` produced the error:
   > *"this conversation could not be loaded"*
4. **Root Cause:** Inspection of the live filesystem on the new Mac showed that the UI relies on SQLite databases inside `~/.gemini/antigravity/conversations/<id>.db`. The original backup in Dropbox only had `brain/` and `config/`; the `conversations/` directory was missing.

---

## 3. DIRECTIVE FOR MACBOOK PRO 2019 AGENT (Source Machine)

> [!IMPORTANT]
> **Hello MacBook Pro 2019 Agent!**
> The user is migrating their environment to a new 2026 Apple Silicon MacBook Pro.
> We ran a test migration on the new Mac with the D2L study notes conversation (`04ea6e69-f1e6-498c-8464-2765327adf7d`).
> The workspace project (`d2l_study`) and transcript/artifacts (`brain/`) migrated cleanly, but the Antigravity UI threw an error (*"this conversation could not be loaded"*).
> 
> **Why:** Antigravity requires the SQLite database files located in `~/.gemini/antigravity/conversations/<id>.db` to list and render conversations in the UI. The initial backup on Dropbox only contained `brain/` and `config/`; the `conversations/` directory was omitted.

### Action Required on MacBook Pro 2019:
Please execute the following command in terminal to copy your local `conversations` directory (including all `.db`, `.db-wal`, and `.db-shm` files) into the shared Dropbox migration folder:

```bash
# Define source and destination paths on Mac 2019
SRC_CONVERSATIONS="$HOME/.gemini/antigravity/conversations"
DST_DROPBOX="$HOME/Dropbox (Personal)/computer_config/migration/antigravity/conversations"

# Ensure target folder exists
mkdir -p "$DST_DROPBOX"

# Copy all conversation databases and WAL journals to Dropbox
cp -R "$SRC_CONVERSATIONS/." "$DST_DROPBOX/"

# Verify copy completion and file count
echo "=== Copied Conversation Databases ==="
ls -lh "$DST_DROPBOX" | head -n 20
echo "Total databases copied: $(ls -1 "$DST_DROPBOX"/*.db 2>/dev/null | wc -l)"
```

### Context & What Happens Next:
1. Once these `.db` files are copied, Dropbox will automatically sync them to the new Mac.
2. On the new Mac, the path translation scripts (`migrate_antigravity.sh` and `test_migrate_d2l.sh`) are already updated to copy these `.db` files directly into the new Mac's `~/.gemini/antigravity/conversations/`.
3. No path rewriting inside the `.db` files is needed immediately because the new Mac's Antigravity agent will load the trajectory and transcript from `brain/`.
4. Please notify the user once this copy completes and files are synced to Dropbox.

---

## 4. Instructions for Mac 2026 (Destination Machine)

Once Dropbox on Mac 2026 finishes syncing the `conversations/` folder:

### 1. Close Antigravity on Mac 2026
Ensure Antigravity IDE is completely quit.

### 2. Execute the Migration Script
Run the updated migration script in standard Terminal or iTerm2:
```bash
cd ~/files/Dropbox/computer_config/dotfiles/macbookpro_2026
./migrate_antigravity.sh
```
*(Or for testing just D2L: `bash test_migrate_d2l.sh`)*

### 3. Path Translations Applied Automatically
The script automatically translates:
- `file:///Users/lunyanghuang/Dropbox%20%28Personal%29` $\to$ `file:///Users/lunyang/files/Dropbox`
- `/Users/lunyanghuang/Dropbox (Personal)` $\to$ `/Users/lunyang/files/Dropbox`
- `/Users/lunyanghuang` $\to$ `/Users/lunyang`

### 4. Restart and Verify
Launch Antigravity on Mac 2026. All conversation histories and projects will now be fully listed in the UI and load cleanly.

---

## 5. Test Case Status (Verified)
- **Execution Date:** 2026-09-07
- **Test Conversation:** `04ea6e69-f1e6-498c-8464-2765327adf7d` (`d2l_study`)
- **Status:** ✅ Verified & Working
- **Results:**
  - `04ea6e69-f1e6-498c-8464-2765327adf7d.db` and `brain/` loaded seamlessly.
  - Full chat history, code artifacts, and plans rendered with zero errors.
  - Conversation successfully populated into the Antigravity left sidebar.
  - Ready for full migration via `./migrate_antigravity.sh` whenever convenient.
