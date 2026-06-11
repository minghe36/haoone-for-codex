#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing Haoone for Codex..."
python3 "${SCRIPT_DIR}/scripts/install_plugin.py" install --force "$@"
echo "Haoone for Codex installed."
echo "Use /haoone, \$haoone, or natural language in Codex."
