# Task 05: Antigravity History & Configuration Migration

**Context:** The user wants to migrate the Antigravity agent's brain (conversation history and configs) to the new Mac. Because the agent actively locks and writes to its database and log files while running, **the Agent itself CANNOT perform this migration.** It must be executed by the user manually while the agent is offline.

## Instructions for the User (NOT the Agent)

### 1. Close Antigravity
Ensure that the Antigravity IDE is closed and the background daemon (`agy`) is completely stopped on the new Mac. If the agent is running, modifying its `brain` directory may result in severe data corruption.

### 2. Execute the Migration Script
A standalone shell script has been prepared to handle the migration. It will automatically:
- Create a safe staging environment.
- Perform the required regex translations to update the old Dropbox path (`/Users/.../Dropbox (Personal)`) to the new File Provider path (`~/Library/CloudStorage/Dropbox`) inside all your conversation logs.
- Inject the translated brain into your new `.gemini/antigravity` application directory.

Open your standard macOS Terminal (or iTerm2) and run:
```bash
cd ~/Library/CloudStorage/Dropbox/computer_config/dotfiles/macbookpro_2026
./migrate_antigravity.sh
```

### 3. Restart and Verify
Once the script says "Complete", you can launch Antigravity on the new Mac. You will find that all your past conversations, memories, and artifacts are fully restored and functioning perfectly with the new filesystem paths.
