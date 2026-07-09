#!/usr/bin/env bash
#
# maclean installer — macOS disk space analyzer & cleaner
# https://github.com/mdshahincoder/maclean
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/mdshahincoder/maclean/main/install.sh | bash
#
set -uo pipefail

REMOTE="https://raw.githubusercontent.com/mdshahincoder/maclean/main/maclean"
INSTALL_DIR="${MACLEAN_INSTALL_DIR:-$HOME/bin}"
BIN="$INSTALL_DIR/maclean"

# ── colors ────────────────────────────────────────────────────────────────────
if [ -t 1 ]; then
  B=$(tput bold) G=$(tput setaf 2) Y=$(tput setaf 3) C=$(tput setaf 6) R=$(tput sgr0)
else B="" G="" Y="" C="" R=""; fi

echo "${C}╭─────────────────────────────────────${R}"
echo "${C}│  ${B}🧹 Installing maclean${R}${C}                  ${R}"
echo "${C}╰─────────────────────────────────────${R}"

# ── sanity ────────────────────────────────────────────────────────────────────
if [ "$(uname)" != "Darwin" ]; then
  echo "${Y}! maclean is built for macOS. You're on $(uname) — it may not work fully.${R}"
fi

if ! command -v curl >/dev/null 2>&1; then
  echo "${Y}✗ curl is required.${R}" >&2; exit 1
fi

# ── install ───────────────────────────────────────────────────────────────────
mkdir -p "$INSTALL_DIR"

echo "${C}› downloading maclean…${R}"
if curl -fsSL "$REMOTE" -o "$BIN"; then
  chmod +x "$BIN"
  echo "${G}✓ installed to $BIN${R}"
else
  # fallback: maybe running from a local clone
  if [ -f "$(pwd)/maclean" ]; then
    cp "$(pwd)/maclean" "$BIN"; chmod +x "$BIN"
    echo "${G}✓ installed (from local clone) to $BIN${R}"
  else
    echo "${Y}✗ download failed. Check your connection or clone the repo manually.${R}" >&2
    exit 1
  fi
fi

# ── PATH setup ────────────────────────────────────────────────────────────────
echo "${C}› ensuring $INSTALL_DIR is on your PATH…${R}"
PATH_LINE="export PATH=\"$INSTALL_DIR:\$PATH\""

ensure_path() {
  local rc="$1"
  [ -f "$rc" ] || return 1
  local marker="# maclean PATH"
  if grep -qF "$marker" "$rc" 2>/dev/null; then
    return 0
  fi
  printf '\n%s\nexport PATH="%s:$PATH"\n' "$marker" "$INSTALL_DIR" >>"$rc"
  echo "${G}✓ added $INSTALL_DIR to PATH in $rc${R}"
}

# zsh is the default shell on modern macOS
if [ -n "${ZSH_VERSION:-}" ] || [ "$SHELL" = "/bin/zsh" ]; then
  ensure_path "$HOME/.zshrc" || ensure_path "$HOME/.zprofile"
elif [ -n "${BASH_VERSION:-}" ]; then
  ensure_path "$HOME/.bash_profile" || ensure_path "$HOME/.bashrc"
else
  ensure_path "$HOME/.profile"
fi

# ── verify ────────────────────────────────────────────────────────────────────
if command -v maclean >/dev/null 2>&1 || [ -x "$BIN" ]; then
  echo ""
  echo "${G}🎉 maclean is ready!${R}"
  echo ""
  echo "  ${B}Get started:${R}"
  echo "    maclean            ${C}# run the guided scan${R}"
  echo "    maclean setup      ${C}# pick your profile${R}"
  echo "    maclean overview   ${C}# quick disk status${R}"
  echo ""
  if ! command -v maclean >/dev/null 2>&1; then
    echo "${Y}Note:${R} start a new terminal, or run:  ${C}source ~/.zshrc${R}"
    echo "         then try:                          ${C}maclean${R}"
  fi
  echo ""
  echo "  ${C}Docs:${R} https://github.com/mdshahincoder/maclean#readme"
else
  echo "${Y}✗ something went wrong — $BIN was not created.${R}" >&2
  exit 1
fi
