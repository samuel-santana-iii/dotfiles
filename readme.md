# 🛠️ Master Terminal Configuration

My personal "Master Class" configuration for Linux. This repository automates the installation and configuration of a modern, Rust-based terminal environment across multiple distributions.

## ⚡ The Stack

* **Shell:** `Zsh` (Autosuggestions, Syntax Highlighting, Custom Git Aliases)
* **Prompt:** `Starship` (Cross-shell, minimal, fast)
* **Navigation:** `Zoxide` (Smarter `cd`)
* **Editor:** `Vim`
* **Viewer:** `Bat` (Better `cat` with syntax highlighting)

---

## 🛑 Prerequisites

### For WSL Users (Windows Side)

If running on WSL, you'll need a Nerd Font installed in Windows Terminal to render icons properly.

1.  **Download:** [JetBrainsMono Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip)
2.  **Install:** Extract -> Select all `.ttf` -> Right Click -> **Install**.
3.  **Configure:** Windows Terminal Settings -> Ubuntu Profile -> Appearance -> Font face -> **JetBrainsMono NF**.

### Supported Distributions

**install.sh** works on:
- **Debian/Ubuntu-based:** Ubuntu, Debian, Linux Mint, etc.
- **Arch-based:** Arch Linux, Manjaro, CachyOS, EndeavourOS, etc.
- **Fedora/RHEL-based:** Fedora, Nobara, AlmaLinux, Rocky Linux, etc.

**install-dev-tools.sh** is distro-agnostic and works on all Linux distributions.

---

## 🚀 Quick Install

On any supported Linux distribution, run these commands:

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
