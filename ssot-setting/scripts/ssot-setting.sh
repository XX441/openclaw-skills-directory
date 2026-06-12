#!/usr/bin/env bash
# ssot-setting.sh — OpenClaw Config SSOT backup with manifest tracking
# Part of skills/ssot-setting/
# v1.1 — Added Skills backup (workspace + system)
# Usage: bash ssot-setting.sh [--dry-run]
set -euo pipefail

DRY_RUN="${1:-}"
MANIFEST_ID=".drive-manifest.json"

# Drive folder IDs (hardcoded from OpenClaw_Config)
RESTORE_FOLDER="1_WgmExnC53d_oqH-Zp2BMNMT6Eisx_cM"    # _Restore/
ARCHIVE_FOLDER="1qJkoisdOpvuGA7Cwi1PiPspNGD0ajcIX"      # _Restore/_Archive/
TIMESTAMP=$(date +%Y-%m-%d_%H%M)
SNAPSHOT_NAME="${TIMESTAMP}"

echo "============================================"
echo "  SSOT Setting v1.1"
echo "  Snapshot: $SNAPSHOT_NAME"
echo "============================================"

# ------------------------------------------------------------------
# Step 0: Load or initialize manifest
# ------------------------------------------------------------------
MANIFEST_FILE=$(mktemp)
# (manifest ID resolved dynamically from _Restore/ below)
cleanup() { rm -f "$MANIFEST_FILE"; }
trap cleanup EXIT

# Try to download existing manifest from _Restore/ (find by name)
MANIFEST_FILE=$(mktemp)
MANIFEST_DRIVE_ID=$(gog drive ls --parent "$RESTORE_FOLDER" 2>/dev/null | grep "$MANIFEST_ID" | awk '{print $1}' | head -1 || true)
if [ -n "$MANIFEST_DRIVE_ID" ]; then
    if gog drive download "$MANIFEST_DRIVE_ID" --out "$MANIFEST_FILE" 2>/dev/null; then
        echo "  Manifest loaded (ID: $MANIFEST_DRIVE_ID)"
    else
        echo '{}' > "$MANIFEST_FILE"
        echo "  New manifest initialized (download failed)"
    fi
else
    echo '{}' > "$MANIFEST_FILE"
    echo "  New manifest initialized"
fi

get_id() {
    # Read file ID from manifest for a given key
    python3 -c "import json; print(json.load(open('$MANIFEST_FILE')).get('$1', ''))"
}

set_id() {
    # Write file ID to manifest for a given key
    local KEY="$1" ID="$2"
    python3 -c "
import json
d = json.load(open('$MANIFEST_FILE'))
d['$KEY'] = '$ID'
json.dump(d, open('$MANIFEST_FILE', 'w'))
"
}

# ------------------------------------------------------------------
# Step 1: Create snapshot folder
# ------------------------------------------------------------------
echo ""
echo "Step 1: Snapshot → _Archive/$SNAPSHOT_NAME"

# Upload each source file individually to the snapshot folder
upload_snapshot() {
    local SRC="$1" NAME="$2"
    if [ -f "$SRC" ]; then
        if [ -z "$DRY_RUN" ]; then
            gog drive upload "$SRC" --parent "$ARCHIVE_FOLDER" --name "$SNAPSHOT_NAME/$NAME" 2>&1 | head -1 > /dev/null
            echo "  ✅ $NAME"
        else
            echo "  [dry-run] would upload: $NAME"
        fi
    else
        echo "  ⚠️  $NAME not found (skipped)"
    fi
}

# We can't upload into a folder that doesn't exist yet.
# Create folder first, then upload into it.
SNAPSHOT_ID=""
if [ -z "$DRY_RUN" ]; then
    SNAPSHOT_ID=$(gog drive mkdir --parent "$ARCHIVE_FOLDER" "$SNAPSHOT_NAME" 2>&1 | grep '^id' | awk '{print $2}')
    echo "  Created snapshot folder: $SNAPSHOT_ID"
fi

upload_snapshot_to_folder() {
    local SRC="$1" NAME="$2"
    if [ -f "$SRC" ] && [ -n "$SNAPSHOT_ID" ]; then
        gog drive upload "$SRC" --parent "$SNAPSHOT_ID" --name "$NAME" 2>&1 > /dev/null
    fi
}

# Core config
upload_snapshot_to_folder ~/.openclaw/openclaw.json openclaw.json
upload_snapshot_to_folder ~/.openclaw/credentials/openclaw-secrets.json openclaw-secrets.json
upload_snapshot_to_folder ~/Library/LaunchAgents/ai.openclaw.gateway.plist ai.openclaw.gateway.plist
upload_snapshot_to_folder ~/Library/LaunchAgents/ai.openclaw.control-ui-https-proxy.plist ai.openclaw.control-ui-https-proxy.plist
upload_snapshot_to_folder ~/.openclaw/control-ui-https-proxy.js control-ui-https-proxy.js
[ -f /tmp/control-ui-cert.pem ] && upload_snapshot_to_folder /tmp/control-ui-cert.pem control-ui-cert.pem
[ -f /tmp/control-ui-key.pem ] && upload_snapshot_to_folder /tmp/control-ui-key.pem control-ui-key.pem
[ -f ~/.openclaw/identity/device.json ] && upload_snapshot_to_folder ~/.openclaw/identity/device.json device.json
[ -f ~/.openclaw/identity/device-auth.json ] && upload_snapshot_to_folder ~/.openclaw/identity/device-auth.json device-auth.json
[ -f ~/.openclaw/devices/paired.json ] && upload_snapshot_to_folder ~/.openclaw/devices/paired.json paired.json
[ -f ~/.openclaw/devices/pending.json ] && upload_snapshot_to_folder ~/.openclaw/devices/pending.json pending.json
[ -f ~/.openclaw/cron/jobs.json ] && upload_snapshot_to_folder ~/.openclaw/cron/jobs.json jobs.json
[ -f ~/.openclaw/cron/jobs-state.json ] && upload_snapshot_to_folder ~/.openclaw/cron/jobs-state.json jobs-state.json
[ -f ~/.openclaw/workspace/skills-lock.json ] && upload_snapshot_to_folder ~/.openclaw/workspace/skills-lock.json skills-lock.json

# Workspace identity files
for f in MEMORY HEARTBEAT SOUL TOOLS AGENTS IDENTITY USER; do
    SRC=~/.openclaw/workspace/${f}.md
    [ -f "$SRC" ] && upload_snapshot_to_folder "$SRC" "workspace-${f}.md"
done

echo "  Snapshot complete"

# ------------------------------------------------------------------
# Step 2: Skills Backup
# ------------------------------------------------------------------
echo ""
echo "Step 2: Skills Backup"

SKILLS_FOLDER="1DydO9PjBkaIxTaxW_zGcam9_vZ76bTa9"
MINI_SKILLS_DIR="$HOME/.openclaw/mini-workspace/skills"
SYSTEM_SKILLS_DIR="/opt/homebrew/lib/node_modules/openclaw/skills"

# Tier 1: Workspace skills → tarball per skill, uploaded to Skills/mini-workspace/ + snapshot
MINI_WS_FOLDER_ID=""
if [ -z "$DRY_RUN" ]; then
    EXISTING_MW=$(gog drive ls --parent "$SKILLS_FOLDER" 2>/dev/null | grep "mini-workspace" | awk '{print $1}' | head -1 || true)
    if [ -n "$EXISTING_MW" ]; then
        MINI_WS_FOLDER_ID="$EXISTING_MW"
        echo "  Reusing mini-workspace folder: $MINI_WS_FOLDER_ID"
    else
        MINI_WS_FOLDER_ID=$(gog drive mkdir --parent "$SKILLS_FOLDER" "mini-workspace" 2>&1 | grep '^id' | awk '{print $2}')
        if [ -z "$MINI_WS_FOLDER_ID" ]; then
            echo "  ⚠️  Failed to create mini-workspace folder (permission?) — skipping skill backup"
        else
            echo "  Created mini-workspace folder: $MINI_WS_FOLDER_ID"
        fi
    fi
fi

if [ -n "$MINI_WS_FOLDER_ID" ] || [ -n "$DRY_RUN" ]; then
    for SKILL_DIR in "$MINI_SKILLS_DIR"/*/; do
        [ ! -d "$SKILL_DIR" ] && continue
        SKILL_NAME=$(basename "$SKILL_DIR")
        TARBALL="/tmp/${SKILL_NAME}.tar.gz"
        tar -czf "$TARBALL" -C "$MINI_SKILLS_DIR" "$SKILL_NAME" 2>/dev/null

        if [ -f "$TARBALL" ]; then
            if [ -z "$DRY_RUN" ] && [ -n "$MINI_WS_FOLDER_ID" ]; then
                EXISTING_ID=$(get_id "skill-${SKILL_NAME}")
                if [ -n "$EXISTING_ID" ]; then
                    RESULT=$(gog drive upload "$TARBALL" --name "${SKILL_NAME}.tar.gz" --replace "$EXISTING_ID" 2>&1)
                    if echo "$RESULT" | grep -q "error\|notFound\|404"; then
                        RESULT=$(gog drive upload "$TARBALL" --parent "$MINI_WS_FOLDER_ID" --name "${SKILL_NAME}.tar.gz" 2>&1)
                        NEW_ID=$(echo "$RESULT" | grep '^id' | awk '{print $2}')
                        [ -n "$NEW_ID" ] && set_id "skill-${SKILL_NAME}" "$NEW_ID"
                    fi
                else
                    RESULT=$(gog drive upload "$TARBALL" --parent "$MINI_WS_FOLDER_ID" --name "${SKILL_NAME}.tar.gz" 2>&1)
                    NEW_ID=$(echo "$RESULT" | grep '^id' | awk '{print $2}')
                    [ -n "$NEW_ID" ] && set_id "skill-${SKILL_NAME}" "$NEW_ID"
                fi
                echo "  ✅ $SKILL_NAME"
            else
                echo "  [dry-run] would backup: $SKILL_NAME"
            fi

            # Also include in snapshot
            if [ -f "$TARBALL" ] && [ -n "$SNAPSHOT_ID" ] && [ -z "$DRY_RUN" ]; then
                gog drive upload "$TARBALL" --parent "$SNAPSHOT_ID" --name "skills-mini-workspace-${SKILL_NAME}.tar.gz" 2>&1 > /dev/null
            fi

            rm -f "$TARBALL"
        fi
    done
fi

# Tier 2: System skills → single tarball in snapshot only
SYS_TARBALL="/tmp/system-skills-${TIMESTAMP}.tar.gz"
if [ -d "$SYSTEM_SKILLS_DIR" ]; then
    tar -czf "$SYS_TARBALL" -C "$(dirname "$SYSTEM_SKILLS_DIR")" "skills" 2>/dev/null
    if [ -f "$SYS_TARBALL" ] && [ -n "$SNAPSHOT_ID" ] && [ -z "$DRY_RUN" ]; then
        gog drive upload "$SYS_TARBALL" --parent "$SNAPSHOT_ID" --name "system-skills-${TIMESTAMP}.tar.gz" 2>&1 > /dev/null
        SYS_SIZE=$(du -h "$SYS_TARBALL" | cut -f1)
        echo "  ✅ system skills ($SYS_SIZE)"
    elif [ -z "$DRY_RUN" ]; then
        echo "  ⚠️  system skills dir not found"
    else
        echo "  [dry-run] would backup system skills"
    fi
    rm -f "$SYS_TARBALL"
fi

echo "  Skills backup complete"

# ------------------------------------------------------------------
# Step 3: Refresh live _Restore/ files (using manifest for --replace)
# ------------------------------------------------------------------
echo ""
echo "Step 3: Refreshing _Restore/ live files"

refresh_file() {
    local SRC="$1" NAME="$2" KEY="$3"
    if [ ! -f "$SRC" ]; then
        echo "  ⚠️  $NAME not found (skipped)"
        return
    fi
    local EXISTING_ID
    EXISTING_ID=$(get_id "$KEY")
    
    if [ -n "$EXISTING_ID" ]; then
        # Replace existing file
        if [ -z "$DRY_RUN" ]; then
            local RESULT
            RESULT=$(gog drive upload "$SRC" --name "$NAME" --replace "$EXISTING_ID" 2>&1)
            # If replace failed (file was deleted), upload fresh
            if echo "$RESULT" | grep -q "error\|notFound\|404"; then
                RESULT=$(gog drive upload "$SRC" --parent "$RESTORE_FOLDER" --name "$NAME" 2>&1)
                local NEW_ID
                NEW_ID=$(echo "$RESULT" | grep '^id' | awk '{print $2}')
                if [ -n "$NEW_ID" ]; then
                    set_id "$KEY" "$NEW_ID"
                fi
            fi
            echo "  ✅ $NAME"
        else
            echo "  [dry-run] would replace: $NAME"
        fi
    else
        # First-time upload
        if [ -z "$DRY_RUN" ]; then
            local RESULT
            RESULT=$(gog drive upload "$SRC" --parent "$RESTORE_FOLDER" --name "$NAME" 2>&1)
            local NEW_ID
            NEW_ID=$(echo "$RESULT" | grep '^id' | awk '{print $2}')
            if [ -n "$NEW_ID" ]; then
                set_id "$KEY" "$NEW_ID"
            fi
            echo "  ✅ $NAME (new)"
        else
            echo "  [dry-run] would upload (new): $NAME"
        fi
    fi
}

# Refresh all files
refresh_file ~/.openclaw/openclaw.json openclaw.json openclaw.json
refresh_file ~/.openclaw/credentials/openclaw-secrets.json openclaw-secrets.json openclaw-secrets.json
refresh_file ~/Library/LaunchAgents/ai.openclaw.gateway.plist ai.openclaw.gateway.plist gateway.plist
refresh_file ~/Library/LaunchAgents/ai.openclaw.control-ui-https-proxy.plist ai.openclaw.control-ui-https-proxy.plist proxy.plist
refresh_file ~/.openclaw/control-ui-https-proxy.js control-ui-https-proxy.js proxy.js
[ -f /tmp/control-ui-cert.pem ] && refresh_file /tmp/control-ui-cert.pem control-ui-cert.pem cert.pem
[ -f /tmp/control-ui-key.pem ] && refresh_file /tmp/control-ui-key.pem control-ui-key.pem key.pem
[ -f ~/.openclaw/identity/device.json ] && refresh_file ~/.openclaw/identity/device.json device.json device.json
[ -f ~/.openclaw/identity/device-auth.json ] && refresh_file ~/.openclaw/identity/device-auth.json device-auth.json device-auth.json
[ -f ~/.openclaw/devices/paired.json ] && refresh_file ~/.openclaw/devices/paired.json paired.json paired.json
[ -f ~/.openclaw/devices/pending.json ] && refresh_file ~/.openclaw/devices/pending.json pending.json pending.json
[ -f ~/.openclaw/cron/jobs.json ] && refresh_file ~/.openclaw/cron/jobs.json jobs.json jobs.json
[ -f ~/.openclaw/cron/jobs-state.json ] && refresh_file ~/.openclaw/cron/jobs-state.json jobs-state.json jobs-state.json
[ -f ~/.openclaw/workspace/skills-lock.json ] && refresh_file ~/.openclaw/workspace/skills-lock.json skills-lock.json skills-lock.json

for f in MEMORY HEARTBEAT SOUL TOOLS AGENTS IDENTITY USER; do
    SRC=~/.openclaw/workspace/${f}.md
    [ -f "$SRC" ] && refresh_file "$SRC" "workspace-${f}.md" "workspace-${f}"
done

# Also update the ssot-setting script itself
SCRIPT_PATH="$(cd "$(dirname "$0")" && pwd)/ssot-setting.sh"
refresh_file "$SCRIPT_PATH" ssot-setting.sh ssot-setting-sh

# ------------------------------------------------------------------
# Step 4: Upload updated manifest
# ------------------------------------------------------------------
echo ""
echo "Step 4: Saving manifest"

if [ -z "$DRY_RUN" ]; then
    # Save manifest locally first, then upload
    cp "$MANIFEST_FILE" /tmp/.drive-manifest.json
    # Check if manifest already exists on Drive
    # Check if manifest already exists on Drive
    MANIFEST_DRIVE_ID=$(gog drive ls --parent "$RESTORE_FOLDER" 2>/dev/null | grep "$MANIFEST_ID" | awk '{print $1}' | head -1 || true)
    if [ -n "$MANIFEST_DRIVE_ID" ]; then
        gog drive upload /tmp/.drive-manifest.json --name "$MANIFEST_ID" --replace "$MANIFEST_DRIVE_ID" 2>&1 > /dev/null
    else
        gog drive upload /tmp/.drive-manifest.json --parent "$RESTORE_FOLDER" --name "$MANIFEST_ID" 2>&1 > /dev/null
    fi
    rm -f /tmp/.drive-manifest.json
    echo "  ✅ Manifest saved"
else
    echo "  [dry-run] would save manifest"
fi

# ------------------------------------------------------------------
# Step 5: Prune old snapshots (keep last 5)
# ------------------------------------------------------------------
echo ""
echo "Step 5: Pruning snapshot history"

if [ -z "$DRY_RUN" ]; then
    SNAPSHOTS=$(gog drive ls --parent "$ARCHIVE_FOLDER" 2>/dev/null | tail -n +3 | grep "folder" | awk '{print $2}' | sort || true)
    COUNT=$(echo "$SNAPSHOTS" | grep -c . || true)
    if [ "$COUNT" -gt 5 ] 2>/dev/null; then
        TO_DELETE=$(echo "$SNAPSHOTS" | head -n $((COUNT - 5)))
        while IFS= read -r name; do
            [ -z "$name" ] && continue
            FID=$(gog drive ls --parent "$ARCHIVE_FOLDER" 2>/dev/null | grep "$name" | awk '{print $1}')
            if [ -n "$FID" ]; then
                gog drive delete "$FID" -y 2>/dev/null || true
                echo "  🗑️  deleted: $name"
            fi
        done <<< "$TO_DELETE"
    else
        echo "  Snapshots: $COUNT (keep ≤ 5, none to prune)"
    fi
else
    echo "  [dry-run] would prune old snapshots"
fi

# ------------------------------------------------------------------
# Summary
# ------------------------------------------------------------------
echo ""
echo "============================================"
echo "  SSOT Setting complete!"
echo "  Snapshot: $SNAPSHOT_NAME"
echo "  History:  _Restore/_Archive/ $(if [ -z "$DRY_RUN" ]; then echo "(kept 5)"; fi)"
echo "============================================"
