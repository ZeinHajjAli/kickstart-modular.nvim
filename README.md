# kickstart-modular.nvim

## What This Is

Personal Neovim configuration based on kickstart, organized as a modular Lua setup.

## Requirements

Hard requirements:
- `git`, `curl`, `unzip`, `make`, C compiler (`gcc`/`clang`)
- `ripgrep` (`rg`)
- `fd` (or `fdfind` on some Linux distros)

Recommended:
- A Nerd Font for icons (set `vim.g.have_nerd_font = true` if you have one)
- Clipboard tool (`xclip` on Linux)

## Supported Platforms

The installer supports:
- macOS (Homebrew)
- Ubuntu/Debian (apt)
- Fedora (dnf)
- Arch (pacman)

Other Linux distros will likely work but may require manual dependency installation.

## Installation

### One-Command Setup (macOS/Linux)

From the repo root:

```sh
./scripts/install.sh
```

This will:
- Detect your OS and package manager
- Install missing dependencies (only if not already present)
- Install Neovim `v0.11.6` (package manager first, tarball fallback, source build if needed)
- Back up existing `~/.config/nvim` and `~/.local/share/nvim`
- Symlink this repo to your config path

If Homebrew is not installed on macOS, install it first from https://brew.sh.

### Manual Install

If you prefer to do it yourself:

1. Install dependencies listed above using your package manager.
2. Install Neovim `v0.11.6` (tarball or source build is fine).
3. Symlink this repo to your config path:

```sh
ln -s /path/to/this/repo "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
```

### First Run

Launch Neovim:

```sh
nvim
```

The plugin manager will bootstrap and install plugins on first run.

## Updating

From the repo root:

```sh
git pull
./scripts/install.sh
```

## Uninstall / Reset

Remove the symlink and data directories:

```sh
rm -rf "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
rm -rf "${XDG_DATA_HOME:-$HOME/.local/share}/nvim"
```

If the installer made backups, restore the latest `*.backup-YYYYMMDD-HHMMSS` as needed.

## Troubleshooting

- Run `:checkhealth` inside Neovim for diagnostics.
- Use `:Lazy` to see plugin status.
- If `fd` is missing but `fdfind` exists, the installer creates a shim at `~/.local/bin/fd`.
- If Neovim isn’t `v0.11.6`, re-run the installer and it will fetch the official tarball.
