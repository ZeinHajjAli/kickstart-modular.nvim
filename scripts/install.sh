#!/usr/bin/env bash
set -euo pipefail

NVIM_VERSION="v0.11.6"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/nvim"
LOCAL_BIN="${HOME}/.local/bin"

timestamp() {
  date "+%Y%m%d-%H%M%S"
}

say() {
  printf "%s\n" "$*"
}

have_cmd() {
  command -v "$1" >/dev/null 2>&1
}

need_sudo() {
  [ "${EUID:-$(id -u)}" -ne 0 ]
}

ensure_dir() {
  mkdir -p "$1"
}

backup_path() {
  local path="$1"
  if [ -e "$path" ] || [ -L "$path" ]; then
    local backup="${path}.backup-$(timestamp)"
    say "Backing up ${path} -> ${backup}"
    mv "$path" "$backup"
  fi
}

link_config() {
  if [ -L "$CONFIG_DIR" ]; then
    local target
    target="$(readlink "$CONFIG_DIR")"
    if [ "$target" = "$REPO_DIR" ]; then
      say "Config already linked to ${REPO_DIR}"
      return
    fi
  fi

  if [ -e "$CONFIG_DIR" ] || [ -L "$CONFIG_DIR" ]; then
    backup_path "$CONFIG_DIR"
  fi

  ensure_dir "$(dirname "$CONFIG_DIR")"
  ln -s "$REPO_DIR" "$CONFIG_DIR"
  say "Linked ${CONFIG_DIR} -> ${REPO_DIR}"
}

backup_state() {
  if [ -e "$DATA_DIR" ] || [ -L "$DATA_DIR" ]; then
    backup_path "$DATA_DIR"
  fi
}

detect_os() {
  local uname_s
  uname_s="$(uname -s)"
  case "$uname_s" in
    Darwin) echo "mac" ;;
    Linux) echo "linux" ;;
    *) echo "unsupported" ;;
  esac
}

detect_arch() {
  local uname_m
  uname_m="$(uname -m)"
  case "$uname_m" in
    x86_64|amd64) echo "x86_64" ;;
    arm64|aarch64) echo "arm64" ;;
    armv7l|armv8l) echo "armv7" ;;
    *) echo "unknown" ;;
  esac
}

detect_pm() {
  if have_cmd brew; then echo "brew"; return; fi
  if have_cmd apt-get; then echo "apt"; return; fi
  if have_cmd dnf; then echo "dnf"; return; fi
  if have_cmd pacman; then echo "pacman"; return; fi
  echo "unknown"
}

add_unique_pkg() {
  local pkg="$1"
  local existing
  for existing in "${missing_pkgs[@]:-}"; do
    if [ "$existing" = "$pkg" ]; then
      return
    fi
  done
  missing_pkgs+=("$pkg")
}

add_pkg_if_missing() {
  local pkg="$1"
  local cmd="${2:-$1}"
  if ! have_cmd "$cmd"; then
    add_unique_pkg "$pkg"
  fi
}

install_missing_packages() {
  local pm="$1"
  shift
  local missing=("$@")

  if [ "${#missing[@]}" -eq 0 ]; then
    say "Dependencies already installed"
    return
  fi

  case "$pm" in
    brew)
      say "Installing missing dependencies via Homebrew: ${missing[*]}"
      brew install "${missing[@]}"
      ;;
    apt)
      say "Installing missing dependencies via apt: ${missing[*]}"
      sudo apt-get update
      sudo apt-get install -y "${missing[@]}"
      ;;
    dnf)
      say "Installing missing dependencies via dnf: ${missing[*]}"
      sudo dnf install -y "${missing[@]}"
      ;;
    pacman)
      say "Installing missing dependencies via pacman: ${missing[*]}"
      sudo pacman -S --noconfirm --needed "${missing[@]}"
      ;;
    *)
      say "No supported package manager found; install dependencies manually"
      ;;
  esac
}

ensure_fd_shim() {
  if have_cmd fd; then return; fi
  if have_cmd fdfind; then
    ensure_dir "$LOCAL_BIN"
    if [ ! -e "${LOCAL_BIN}/fd" ]; then
      ln -s "$(command -v fdfind)" "${LOCAL_BIN}/fd"
      say "Created fd shim at ${LOCAL_BIN}/fd"
    fi
  fi
}

nvim_installed_version() {
  if ! have_cmd nvim; then
    echo ""
    return
  fi
  nvim --version | head -n 1 | awk '{print $2}'
}

install_nvim_from_tarball() {
  local os="$1"
  local arch="$2"
  local url=""
  local tmp_dir
  local install_dir
  local bin_dir
  local tarball=""

  case "$os" in
    mac)
      case "$arch" in
        x86_64) tarball="nvim-macos-x86_64.tar.gz" ;;
        arm64) tarball="nvim-macos-arm64.tar.gz" ;;
      esac
      ;;
    linux)
      case "$arch" in
        x86_64) tarball="nvim-linux-x86_64.tar.gz" ;;
        arm64) tarball="nvim-linux-arm64.tar.gz" ;;
      esac
      ;;
  esac

  if [ -z "$tarball" ]; then
    say "No official tarball for ${os}/${arch}."
    return 1
  fi

  url="https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/${tarball}"
  tmp_dir="$(mktemp -d)"
  say "Downloading Neovim ${NVIM_VERSION} from ${url}"
  curl -fL "$url" -o "${tmp_dir}/${tarball}"
  tar -C "$tmp_dir" -xzf "${tmp_dir}/${tarball}"

  if [ "$os" = "mac" ]; then
    install_dir="/usr/local/opt/nvim"
  else
    install_dir="/opt/nvim"
  fi

  if need_sudo && [ ! -w "${install_dir%/*}" ]; then
    install_dir="$HOME/.local/nvim"
    bin_dir="$LOCAL_BIN"
  else
    bin_dir="/usr/local/bin"
  fi

  if [ "$os" = "linux" ]; then
    if [ -d "$install_dir" ]; then
      if need_sudo; then sudo rm -rf "$install_dir"; else rm -rf "$install_dir"; fi
    fi
  else
    if [ -d "$install_dir" ]; then
      if need_sudo; then sudo rm -rf "$install_dir"; else rm -rf "$install_dir"; fi
    fi
  fi

  if need_sudo && [ "$install_dir" != "$HOME/.local/nvim" ]; then
    sudo mkdir -p "$install_dir"
    sudo cp -R "${tmp_dir}/nvim-macos-x86_64"/* "$install_dir" 2>/dev/null || true
    sudo cp -R "${tmp_dir}/nvim-macos-arm64"/* "$install_dir" 2>/dev/null || true
    sudo cp -R "${tmp_dir}/nvim-linux-x86_64"/* "$install_dir" 2>/dev/null || true
    sudo cp -R "${tmp_dir}/nvim-linux-arm64"/* "$install_dir" 2>/dev/null || true
  else
    mkdir -p "$install_dir"
    cp -R "${tmp_dir}/nvim-macos-x86_64"/* "$install_dir" 2>/dev/null || true
    cp -R "${tmp_dir}/nvim-macos-arm64"/* "$install_dir" 2>/dev/null || true
    cp -R "${tmp_dir}/nvim-linux-x86_64"/* "$install_dir" 2>/dev/null || true
    cp -R "${tmp_dir}/nvim-linux-arm64"/* "$install_dir" 2>/dev/null || true
  fi

  ensure_dir "$bin_dir"
  if need_sudo && [ "$bin_dir" != "$LOCAL_BIN" ]; then
    sudo ln -sf "${install_dir}/bin/nvim" "${bin_dir}/nvim"
  else
    ln -sf "${install_dir}/bin/nvim" "${bin_dir}/nvim"
  fi

  say "Installed Neovim ${NVIM_VERSION} to ${install_dir}"
}

install_nvim_source() {
  local tmp_dir
  tmp_dir="$(mktemp -d)"
  say "Building Neovim ${NVIM_VERSION} from source"
  git clone --depth 1 --branch "$NVIM_VERSION" https://github.com/neovim/neovim.git "$tmp_dir/neovim"
  make -C "$tmp_dir/neovim" CMAKE_BUILD_TYPE=Release
  if need_sudo; then
    sudo make -C "$tmp_dir/neovim" install
  else
    make -C "$tmp_dir/neovim" install
  fi
}

ensure_nvim() {
  local os="$1"
  local arch="$2"
  local pm="$3"

  local current
  current="$(nvim_installed_version)"
  if [ "$current" = "$NVIM_VERSION" ]; then
    say "Neovim ${NVIM_VERSION} already installed"
    return
  fi

  case "$pm" in
    brew)
      if ! have_cmd nvim; then
        say "Installing Neovim via Homebrew"
        brew install neovim
      else
        say "Upgrading Neovim via Homebrew"
        brew upgrade neovim || true
      fi
      ;;
    apt)
      say "Installing/Upgrading Neovim via apt"
      sudo apt-get install -y neovim
      ;;
    dnf)
      say "Installing/Upgrading Neovim via dnf"
      sudo dnf install -y neovim
      ;;
    pacman)
      say "Installing/Upgrading Neovim via pacman"
      sudo pacman -S --noconfirm --needed neovim
      ;;
  esac

  current="$(nvim_installed_version)"
  if [ "$current" = "$NVIM_VERSION" ]; then
    say "Neovim ${NVIM_VERSION} installed via package manager"
    return
  fi

  if ! install_nvim_from_tarball "$os" "$arch"; then
    say "Falling back to source build"
    install_nvim_source
  fi
}

main() {
  local os arch pm
  os="$(detect_os)"
  arch="$(detect_arch)"
  pm="$(detect_pm)"

  if [ "$os" = "unsupported" ]; then
    say "Unsupported OS"
    exit 1
  fi

  say "OS: ${os}"
  say "Arch: ${arch}"
  say "Package manager: ${pm}"

  backup_state
  link_config

  if [ "$os" = "mac" ]; then
    if [ "$pm" != "brew" ]; then
      say "Homebrew not found. Install it from https://brew.sh and re-run."
    else
      missing_pkgs=()
      add_pkg_if_missing git
      add_pkg_if_missing curl
      add_pkg_if_missing unzip
      add_pkg_if_missing make
      add_pkg_if_missing gcc
      add_pkg_if_missing ripgrep rg
      add_pkg_if_missing fd
      install_missing_packages "$pm" "${missing_pkgs[@]}"
    fi
  else
    case "$pm" in
      apt)
        missing_pkgs=()
        add_pkg_if_missing git
        add_pkg_if_missing curl
        add_pkg_if_missing unzip
        add_pkg_if_missing make
        add_pkg_if_missing gcc
        add_pkg_if_missing ripgrep rg
        add_pkg_if_missing xclip
        add_pkg_if_missing fd-find fdfind
        install_missing_packages "$pm" "${missing_pkgs[@]}"
        ;;
      dnf)
        missing_pkgs=()
        add_pkg_if_missing git
        add_pkg_if_missing curl
        add_pkg_if_missing unzip
        add_pkg_if_missing make
        add_pkg_if_missing gcc
        add_pkg_if_missing ripgrep rg
        add_pkg_if_missing xclip
        add_pkg_if_missing fd-find fd
        install_missing_packages "$pm" "${missing_pkgs[@]}"
        ;;
      pacman)
        missing_pkgs=()
        add_pkg_if_missing git
        add_pkg_if_missing curl
        add_pkg_if_missing unzip
        add_pkg_if_missing ripgrep rg
        add_pkg_if_missing xclip
        add_pkg_if_missing fd
        if ! have_cmd make || ! have_cmd gcc; then
          add_unique_pkg base-devel
        fi
        install_missing_packages "$pm" "${missing_pkgs[@]}"
        ;;
      *)
        say "Unsupported Linux package manager. Install deps manually."
        ;;
    esac
  fi

  ensure_fd_shim
  ensure_nvim "$os" "$arch" "$pm"

  say "Done. Launch with: nvim"
}

main "$@"
