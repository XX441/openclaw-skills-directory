---
name: diagnose
description: Systematically diagnose a problem, error, or unexpected behavior. Follow a structured troubleshooting approach to identify root causes. Use when user mentions "diagnose", "troubleshoot", "what's wrong", "why isn't this working", "debug", or reports an error or failure.
adapted_from: mattpocock/skills (77.8k ⭐ GitHub)
---

Diagnose the problem systematically. Follow a structured approach, ruling out causes one by one.

## Process

1. **Observe** — What exactly is happening? What's the error message? What were you expecting?
2. **Reproduce** — Can we reproduce the issue? Is it consistent or intermittent?
3. **Isolate** — What changed recently? Config? Code? Dependencies? Permissions?
4. **Hypothesize** — List the most likely causes, ordered by probability.
5. **Test** — Test each hypothesis, starting with the most likely. One at a time.
6. **Fix** — Once root cause is confirmed, propose the fix.

## When doing technical diagnosis

- Check relevant logs first (`openclaw logs`, `~/.openclaw/logs/`)
- Check config state (`openclaw.json`, `openclaw status`)
- Check service health (`openclaw health`, `launchctl list`)
- Check Drive for known issues or past fixes

## Output

After diagnosis, provide:
1. Root cause (what went wrong)
2. Fix (how to resolve it)
3. Prevention (how to avoid this in future)
