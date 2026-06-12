#!/usr/bin/env bash
# ssot-restore.sh — Restore OpenClaw config from Drive _Restore/ backup
# Part of skills/ssot-setting/
# Usage: bash ssot-restore.sh [--dry-run] [--snapshot <timestamp>]
set -euo pipefail

MODE="${1:-live}"       # "live" = from _Restore/, "snapshot" = from _Restore/_Archive/<ts>/
SNAPSHOT="${2:-}"

# Drive folder IDs
RESTORE_FOLDER="1_WgmExnC53d_oqH-Zp2BMNMT6Eisx_cM"
ARCHIVE_FOLDER="1qJkoisdOpvuGA7Cwi1PiPspNGD0ajcIX"
TMP=$(mktemp -d)
cleanup() { rm -rf "$TMP"; }
trap cleanup EXIT

echo "============================================"
echo "  SSOT Restore v1.0"
[[ -n "$SNAPSHOT" ]] && echo "  Snapshot: $SNAPSHOT" || echo "  Source: _Restore/ (live)"
echo "============================================"

# Determine source folder
if [ -n "$SNAPSHOT" ]; then
    # Find snapshot folder
    SNAPSHOT_ID=$(gog drive ls --parent "$ARCHIVE_FOLDER" 2>/dev/null | grep "$SNAPSHOT" | awk '{print $1}' | head -1)
    if [ -z "$SNAPSHOT_ID" ]; then
        echo "ERROR: Snapshot '$SNAPSHOT' not found in _Archive/"
        echo "Available snapshots:"
        gog drive ls --parent "$ARCHIVE_FOLDER" 2>/dev/null | tail -n +3 | awk '{print $2}'
        exit 1
    fi
    SOURCE="$SNAPSHOT_ID"
    echo "   Source (snapshot): $SNAPSHOT ($SNAPSHOT_ID)"
else
    SOURCE="$RESTORE_FOLDER"
    echo "   Source: _Restore/ (live backup)"
fi

# ------------------------------------------------------------------
# Download & restore each file
# ------------------------------------------------------------------
restore_file() {
    local DRIVE_NAME="$1" LOCAL_PATH="$2" OWNER="${3:-}"
    echo -n "   $DRIVE_NAME → $LOCAL_PATH ... "
    
    # Find file in source folder
    FILE_ID=$(gog drive ls --parent "$SOURCE" 2>/dev/null | grep "$DRIVE_NAME" | awk '{print $1}' | head -1 || true)
    if [ -z "$FILE_ID" ]; then
        echo "⚠️  not in backup (skipped)"
        return
    fi
    
    # Download
    mkdir -p "$(dirname "$LOCAL_PATH")"
    gog drive download "$FILE_ID" --out "$LOCAL_PATH" 2>/dev/null || { echo "❌ download failed"; return; }
    
    # Set ownership
    [ -n "$OWNER" ] && chown "$OWNER" "$LOCAL_PATH" 2>/dev/null || true
    
    echo "✅"
}

echo ""
echo "Restoring config files..."

restore_file "openclaw.json" "$HOME/.openclaw/openclaw.json"
restore_file "openclaw-secrets.json" "$HOME/.openclaw/credentials/openclaw-secrets.json"

echo ""
echo "Restoring LaunchAgents..."

restore_file "ai.openclaw.gateway.plist" "$HOME/Library/LaunchAgents/ai.openclaw.gateway.plist"
restore_file "ai.openclaw.control-ui-https-proxy.plist" "$HOME/Library/LaunchAgents/ai.openclaw.control-ui-https-proxy.plist"

echo ""
echo "Restoring HTTPS proxy..."

restore_file "control-ui-https-proxy.js" "$HOME/.openclaw/control-ui-https-proxy.js"

# Optional files (may not exist in backup)
echo ""
echo "Restoring device/auth files (optional)..."

restore_file "device.json" "$HOME/.openclaw/identity/device.json" || true
restore_file "device-auth.json" "$HOME/.openclaw/identity/device-auth.json" || true
restore_file "paired.json" "$HOME/.openclaw/devices/paired.json" || true
restore_file "pending.json" "$HOME/.openclaw/devices/pending.json" || true

echo ""
echo "Restoring cron jobs..."

restore_file "jobs.json" "$HOME/.openclaw/cron/jobs.json"
restore_file "jobs-state.json" "$HOME/.openclaw/cron/jobs-state.json"

echo ""
echo "Restoring plugin configs..."

restore_file "skills-lock.json" "$HOME/.openclaw/workspace/skills-lock.json"

echo ""
echo "Restoring workspace identity files..."

for f in MEMORY HEARTBEAT SOUL TOOLS AGENTS IDENTITY USER; do
    restore_file "workspace-${f}.md" "$HOME/.openclaw/workspace/${f}.md"
done

echo ""
echo "============================================"
echo "  SSOT Restore complete!"
echo ""
echo "  Next steps:"
echo "    1. Verify openclaw.json is correct"
echo "    2. Restart OpenClaw: openclaw gateway restart"
echo "    3. Verify channels: openclaw channels status --probe"
echo "============================================"
