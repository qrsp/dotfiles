# dotfiles

A dotfiles repository, managed with [Dotbot](https://github.com/anishathalye/dotbot).

## Getting Started

### 📋 Prerequisites

Before installing, ensure you have the following prerequisites installed on your system:
- **Git** (to clone and manage submodules)
- **Python** (required by Dotbot and the uninstall script)

### Installation

To deploy these dotfiles, clone the repository recursively to fetch the Dotbot submodule, and run the installation script:

```bash
git clone --recursive https://github.com/qrsp/dotfiles.git
cd dotfiles-github
./install
```

> [!NOTE]  
> **Automatic Backups**: The `install` script automatically detects existing `.bashrc`, `.profile`, and `.zshenv` files in your home directory and backs them up to `~/.bashrc.bk`, `~/.profile.bk`, and `~/.zshenv.bk` respectively to ensure you don't lose any previous configuration.

---

## Uninstallation

If you wish to remove all symlinks created by Dotbot and restore your system's original state, you can run the uninstall script:

```bash
python uninstall.py
```

This script will parse your `install.conf.yaml` and cleanly delete all of the symlinks it established, leaving your original files intact.
