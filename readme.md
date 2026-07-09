# 🛠️ Master Terminal Configuration (WSL)

My personal "Master Class" configuration for Linux/WSL. This repository automates the installation and configuration of a modern, Rust-based terminal environment.

## ⚡ The Stack

* **Shell:** `Zsh` (Autosuggestions, Syntax Highlighting, Custom Git Aliases)
* **Prompt:** `Starship` (Cross-shell, minimal, fast)
* **Navigation:** `Zoxide` (Smarter `cd`)
* **Editor:** `Vim`
* **Viewer:** `Bat` (Better `cat` with syntax highlighting)

---

## 🛑 Prerequisites (Windows Side)

Since this runs on WSL, the Linux subsystem cannot render icons unless the **Windows Terminal** is using a patched font.

1.  **Download:** [JetBrainsMono Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip)
2.  **Install:** Extract -> Select all `.ttf` -> Right Click -> **Install**.
3.  **Configure:** Windows Terminal Settings -> Ubuntu Profile -> Appearance -> Font face -> **JetBrainsMono NF**.

---

## 🚀 Quick Install

On a fresh Ubuntu/WSL machine, run these commands:

```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles

# Run the core shell setup
chmod +x ~/dotfiles/install.sh
~/dotfiles/install.sh

# (Optional) Install development tools
chmod +x ~/dotfiles/install-dev-tools.sh
~/dotfiles/install-dev-tools.sh
```

**Restart your terminal** after the scripts finish.

---

## 📂 Repository Structure

The `install.sh` script creates symlinks from your home directory to this folder. This allows you to edit files here and have changes apply instantly.

```text
~/dotfiles/
├── install.sh              # Core shell setup (zsh, vim, starship, zoxide)
├── install-dev-tools.sh    # Development tools (Node, AI CLIs)
├── zshrc                   # Linked to ~/.zshrc
├── vimrc                   # Linked to ~/.vimrc
└── config/
    └── starship.toml       # Linked to ~/.config/starship.toml
```

---

## 🔧 Manual Mappings (Reference)

If the script fails or you prefer manual linking:

| System Location | Repo Location | Description |
| :--- | :--- | :--- |
| `~/.zshrc` | `./zshrc` | Main shell config |
| `~/.vimrc` | `./vimrc` | Editor config |
| `~/.config/starship.toml` | `./config/starship.toml` | Prompt theme |

## ⌨️ Cheatsheet

### Zoxide (Navigation)
* `z <name>`: Jump to directory (fuzzy match)
* `z -`: Go back to previous directory

### Vim (Editor)
* **Paste from Windows:** `Ctrl` + `Shift` + `v` (Make sure to be in Insert Mode `i`)
