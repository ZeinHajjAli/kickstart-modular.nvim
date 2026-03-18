# nvim config

Personal Neovim configuration built on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).

## Requirements

- `git`, `curl`, `unzip`, `make`, C compiler (`gcc`/`clang`)
- `ripgrep` (`rg`)
- `fd` (or `fdfind` on some Linux distros)
- A [Nerd Font](https://www.nerdfonts.com/) for icons
- `xclip` on Linux (clipboard)

## Installation

```sh
./scripts/install.sh
```

This detects your OS and package manager, installs missing dependencies, installs Neovim `v0.11.6`, backs up any existing `~/.config/nvim` and `~/.local/share/nvim`, then symlinks this repo to your config path.

Supported platforms: macOS (Homebrew), Ubuntu/Debian (apt), Fedora (dnf), Arch (pacman).

On macOS, [Homebrew](https://brew.sh) must be installed first.

### Manual

```sh
ln -s /path/to/this/repo "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
nvim  # bootstraps plugins on first launch
```

## Updating

```sh
git pull
./scripts/install.sh
```

## Uninstall

```sh
rm -rf "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
rm -rf "${XDG_DATA_HOME:-$HOME/.local/share}/nvim"
```
