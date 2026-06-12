---
name: ssot-setting
description: 'OpenClaw Config SSOT — backup, snapshot, and restore system. Use when: Leo says "SSOT Setting", or you need to snapshot OpenClaw config before/after changes. Part of the ssot-* skill family.'
---

# SSOT Setting (ssot-setting)

Part of the **ssot-* skill family**. Siblings: `ssot-knowledge-graph` (connect files), `ssot-steward` (file hygiene).

## What It Does

Snapshots the entire OpenClaw runtime state to Drive — config files, credentials, LaunchAgents, device auth, cron jobs, workspace identity files — and keeps versioned history for disaster recovery.

## Trigger

Leo says: **"SSOT Setting"**

## How It Works

### Manifest-Based Tracking

A `.drive-manifest.json` lives in `_Restore/` on Drive, tracking the Drive file ID of every live backup file. This prevents duplicate uploads:

```json
{
  "openclaw-secrets.json": "1abc...",
  "workspace-MEMORY.md": "2def...",
}
```

**First run:** Upload all files → record Drive IDs.
**Subsequent runs:** Read manifest → `--replace <ID>` → update manifest.

No more duplicate files.

### Flow

```
"SSOT Setting"
    │
    ├── 1. Snapshot → _Restore/_Archive/<timestamp>/
    │      Full copy of all source files (preserves history, keep 5)
    │
    ├── 2. Refresh _Restore/ live files
    │      Read manifest → --replace each file → update manifest
    │
    └── 3. Report: what was backed up, what changed
```

## Files Managed

| Source | Destination |
|--------|-------------|
| `~/.openclaw/openclaw.json` | `openclaw.json` |
| `~/.openclaw/credentials/openclaw-secrets.json` | `openclaw-secrets.json` |
| `~/Library/LaunchAgents/ai.openclaw.gateway.plist` | `ai.openclaw.gateway.plist` |
| `~/Library/LaunchAgents/ai.openclaw.control-ui-https-proxy.plist` | `ai.openclaw.control-ui-https-proxy.plist` |
| `~/.openclaw/control-ui-https-proxy.js` | `control-ui-https-proxy.js` |
| `/tmp/control-ui-cert.pem` | `control-ui-cert.pem` |
| `/tmp/control-ui-key.pem` | `control-ui-key.pem` |
| Device auth + pairing files | `device.json`, `device-auth.json`, `paired.json`, `pending.json` |
| Cron jobs | `jobs.json`, `jobs-state.json` |
| Plugin configs | `skills-lock.json`, `dingtalk-plugin.json` |
| Workspace identity files | `workspace-{MEMORY,HEARTBEAT,SOUL,TOOLS,AGENTS,IDENTITY,USER}.md` |

## Usage

```bash
# Full backup (normal operation)
bash skills/ssot-setting/scripts/ssot-setting.sh

# Quick check without uploading
bash skills/ssot-setting/scripts/ssot-setting.sh --dry-run
```

## Restore

From `_Restore/` live files → download everything back to local paths.
From `_Restore/_Archive/<timestamp>/` → pick a specific snapshot.
