#!/usr/bin/env bash
set -euo pipefail

msg='Run for cover, i am a Dragon'

# Verify cowsay exists
if ! command -v cowsay >/dev/null 2>&1; then
  echo "cowsay is not installed. Please install cowsay and re-run." >&2
  exit 1
fi

# Prefer dragon cowfile if available, otherwise fall back to default cow
if cowsay -l | grep -qw dragon; then
  cowsay -f dragon "$msg"
else
  echo "Warning: 'dragon' cowfile not found, falling back to default cow." >&2
  cowsay "$msg"
fi
