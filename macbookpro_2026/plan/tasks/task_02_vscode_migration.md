# Task 02: VS Code Configuration Migration

**Context:** The user wants to seamlessly carry over their VS Code experience from the 2019 MacBook. VS Code configurations are highly portable, but paths need updating for Apple Silicon.

## Implementation Steps

### 1. Configuration Fixes
- **Python Default Interpreter:**
  - File: `vs_code_config/setting/settings.json` (Line 149)
  - Changed from legacy Intel path `"/usr/local/bin/python3"` to `"python3"` to support Apple Silicon and project virtual environments.

### 2. Verify Target Directory
- Confirmed active target directory on this Mac:
  `$HOME/Library/Application Support/Code/User/`

### 3. Establish Softlinks via Script
- Modularized `softlink_config_file.sh` to allow per-component execution (`./softlink_config_file.sh vscode`).
- Executed linkage via script:
  - `vs_code_config/setting/settings.json` -> `$vscode_dir/settings.json`
  - `vs_code_config/keybinding/keybindings.json` -> `$vscode_dir/keybindings.json`
  - `vs_code_config/snippet/shell_snippet.json` -> `$vscode_dir/snippets/shellscript.json`
  - `vs_code_config/snippet/python_snippet.json` -> `$vscode_dir/snippets/python.json`

### 4. Verification
- Verified symlinks resolve correctly in `$HOME/Library/Application Support/Code/User/`.
- Verified `code` CLI command at `/usr/local/bin/code` (v1.136.1).

---

## Status & Notes (Completed)
- **Execution Date:** 2026-09-07
- **Status:** ✅ Completed and Verified
- **Verification Details:**
  - `settings.json`: Successfully softlinked and Python interpreter path set to `"python3"`.
  - `keybindings.json`: Successfully softlinked with Logitech G915 TKL mappings intact.
  - **Keyboard Mapping Rationale (Logitech G915 TKL Configuration):**
    - **macOS Modifier Keys Settings for G915 TKL:**
      - Command Key $\to$ `Control`
      - Option Key $\to$ `Option`
      - Control Key $\to$ `Command`
      - Caps Lock Key $\to$ `Control`
    - **Physical Layout (from left to right on G915 TKL bottom row):**
      1. Physical `Ctrl` key (originally Control) $\to$ mapped to macOS `Command` (takes Windows `Ctrl` role).
      2. Physical `Windows` key (originally Command) $\to$ mapped to macOS `Control`.
      3. Physical `Alt` key (originally Option) $\to$ remains macOS `Option` (recognized as `Alt` in VS Code / Windows role).
    - **Outcome:** Option acts as `Alt` (as in Windows) and Command acts as `Ctrl` (as in Windows). Most standard key combinations (e.g. Alt+W, Ctrl+C) operate naturally according to physical key positions without requiring artificial remapping.
    - **Caps Lock:** Remapped to `Control` to enable Caps Lock as a custom modifier key (e.g., Caps + Space).
  - `snippets/`: Both `python.json` and `shellscript.json` softlinked into User snippets.
  - `code` command: Verified working (`code --version` reports 1.136.1).
  - **Font Caveat:** `settings.json` specifies `"editor.fontFamily": "Fira Code Light"` with ligatures enabled. The Fira Code font family was installed in Task 01 via `font-fira-code-nerd-font` into `~/Library/Fonts`, ensuring code ligatures and symbols render properly.
