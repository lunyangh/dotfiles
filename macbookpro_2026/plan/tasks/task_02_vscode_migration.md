# Task 02: VS Code Configuration Migration

**Context:** The user wants to seamlessly carry over their VS Code experience from the 2019 MacBook without any changes. VS Code configurations are highly portable.

## Instructions for Agent

### 1. Source Files
The meticulously updated 2026 configuration files have already been prepared in:
`computer_config/dotfiles/macbookpro_2026/vs_code_config/`

### 3. Establish Softlinks
**AGENT ACTION: Verify the VS Code path first!**
Do not blindly assume the path is `~/Library/Application Support/Code/User/`. The new Mac might use VS Code Insiders (`Code - Insiders`) or a different structure. 
1. **Verify** the actual active VS Code User directory on the new Mac.
2. Once the path is confirmed, create symlinks from the copied `vs_code_config` folder to that system directory:
   - Link `settings.json`
   - Link `keybindings.json`
   - Link the `snippet` folder contents (e.g., `python_snippet.json`, `shell_snippet.json`) into the `User/snippets/` folder.

*Note: Ensure the target directories exist before linking.*
