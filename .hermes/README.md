# Hermes public config backup

This folder contains public-safe snapshots of Jacob's local Hermes/Goku configuration.

Tracked here:

- `config.yaml` with personal channel IDs redacted
- `SOUL.md`
- `skins/goku.yaml`
- launchd plist files under `Library/LaunchAgents/`

Not tracked here:

- `.env`
- OAuth/auth files
- Google client secrets or tokens
- browser profiles/cookies
- WhatsApp session data
- Hermes logs, sessions, state databases, document cache, and raw cron jobs

The private operational source of truth for the local agent stack is `~/brain/truth/agent-stack.md`.
