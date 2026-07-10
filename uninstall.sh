#!/usr/bin/env bash
#
# maclean uninstaller — remove maclean completely from your machine
# https://github.com/mdshahincoder/maclean
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/mdshahincoder/maclean/main/uninstall.sh | bash
#
# Removes:
#   * the maclean script (from ~/bin, ~/.local/bin, or wherever it's installed)
#   * the config directory (~/.config/maclean)
#   * the PATH entry maclean added to your shell rc files
#
# Your projects, caches, and everything maclean ever cleaned stay untouched —
# only the tool itself is removed.
#
set -uo pipefail

# ── colors ────────────────────────────────────────────────────────────────────
if [ -t 1 ]; then
  B=$(tput bold) G=$(tput setaf 2) Y=$(tput setaf 3) C=$(tput setaf 6) R=$(tput sgr0)
else B="" G="" Y="" C="" R=""; fi

CONFIG_DIR="${MACLEAN_CONFIG_DIR:-$HOME/.config/maclean}"
INSTALL_DIR="${MACLEAN_INSTALL_DIR:-$HOME/bin}"

printf "%s╭─────────────────────────────────────%s\n" "$C" "$R"
printf "%s│  %s🧹 Uninstalling maclean%s             %s\n" "$C" "$B" "$C" "$R"
printf "%s╰─────────────────────────────────────%s\n" "$C" "$R"

# ── find & remove the binary ──────────────────────────────────────────────────
removed=""
found=$(command -v maclean 2>/dev/null)
if [ -n "$found" ]; then
  candidates=("$found" "$HOME/bin/maclean" "$INSTALL_DIR/maclean" "$HOME/.local/bin/maclean")
else
  candidates=("$HOME/bin/maclean" "$INSTALL_DIR/maclean" "$HOME/.local/bin/maclean")
fi
for bin in "${candidates[@]}"; do
  if [ -f "$bin" ]; then rm -f "$bin" && removed="$bin"; fi
done

# ── remove config directory ───────────────────────────────────────────────────
rm -rf "$CONFIG_DIR" 2>/dev/null

# ── clean PATH entries from shell rc files ────────────────────────────────────
for rc in "$HOME/.zshrc" "$HOME/.zprofile" "$HOME/.bash_profile" "$HOME/.bashrc" "$HOME/.profile"; do
  [ -f "$rc" ] || continue
  if grep -q "# maclean PATH" "$rc" 2>/dev/null; then
    grep -v "# maclean PATH" "$rc" \
      | grep -v 'export PATH=.*$HOME/bin:\|export PATH=".*$HOME/bin' \
      > "$rc.tmp" 2>/dev/null && mv "$rc.tmp" "$rc"
    rm -f "$rc.tmp"
  fi
done

# ── report ────────────────────────────────────────────────────────────────────
if [ -n "$removed" ]; then
  printf "%s✓ removed binary: %s%s\n" "$G" "$removed" "$R"
else
  printf "%s! no installed binary found in common locations%s\n" "$Y" "$R"
fi
printf "%s✓ removed config: %s%s\n" "$G" "$CONFIG_DIR" "$R"
printf "%s✓ cleaned PATH entries from shell rc files%s\n" "$G" "$R"

printf "\n%s🎉 maclean is fully uninstalled.%s\n" "$G" "$R"
printf "%sStart a new terminal (or run: source ~/.zshrc) for the PATH change to take effect.%s\n" "$C" "$R"
