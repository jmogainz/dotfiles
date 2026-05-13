---
name: hermes-ops
description: Use when Jacob asks Codex to debug, improve, configure, back up, restart, update, or reason about his Hermes/Goku agent, Hermes gateway, GBrain memory, browser automation, WhatsApp gateway, launchd services, local Hermes fork, or related dotfiles backups.
---

# Hermes Ops

Use this for Jacob's local Goku/Hermes stack. Treat this as operational runbook plus guardrails.

## Core State

- Hermes source: `~/.hermes/hermes-agent`
- Hermes branch: `jacob/custom-hermes`
- Hermes fork remote: `git@github.com:jmogainz/hermes-agent.git`
- Upstream remote: `git@github.com:NousResearch/hermes-agent.git`
- Hermes config: `~/.hermes/config.yaml`
- Hermes soul: `~/.hermes/SOUL.md`
- Hermes gateway launchd label: `ai.hermes.gateway`
- Chrome CDP launchd label: `ai.hermes.chrome-cdp`
- GBrain repo: `~/gbrain`
- Brain data repo: `~/brain`
- Durable agent truth page: `~/brain/truth/agent-stack.md`
- Public dotfiles repo: `~/dotfiles`

## Secret Boundary

Never commit secrets, tokens, cookies, browser profiles, auth DBs, session transcripts, logs, or raw personal message content to public dotfiles.

Exclude at minimum:

- `~/.hermes/.env`
- `~/.hermes/auth.json`
- `~/.hermes/google_client_secret.json`
- `~/.hermes/google_token.json`
- `~/.hermes/chrome-debug/`
- `~/.hermes/secrets/`
- `~/.hermes/whatsapp/`
- `~/.hermes/sessions/`
- `~/.hermes/logs/`
- `~/.hermes/state.db*`
- `~/.codex/auth.json`
- `~/.codex/internal_storage.json`
- shell histories and SQLite state/log DBs

Before committing public dotfiles, inspect staged diffs and run a secret scan or at least grep staged files for token-like strings.

## Common Debug Flow

1. Check gateway state:
   - `launchctl print gui/$(id -u)/ai.hermes.gateway`
   - `tail -120 ~/.hermes/logs/gateway.log`
   - `tail -120 ~/.hermes/logs/gateway.error.log`
2. Check Hermes code state:
   - `git -C ~/.hermes/hermes-agent status --short --branch`
   - `git -C ~/.hermes/hermes-agent log -5 --oneline`
3. Check live config:
   - `hermes skills list`
   - `sed -n '1,260p' ~/.hermes/config.yaml`
   - `sed -n '1,220p' ~/.hermes/SOUL.md`
4. For GBrain/memory issues:
   - Prefer Hermes MCP tools when inside Hermes.
   - From Codex shell, load secrets before GBrain sync/embed:
     `set -a; source ~/.hermes/.env; set +a; gbrain sync --repo ~/brain && gbrain embed --stale`
   - Update `~/brain/truth/agent-stack.md` for durable setup changes.

## Making Hermes Code Changes

1. Work in `~/.hermes/hermes-agent` on `jacob/custom-hermes`.
2. Keep changes scoped; do not revert unrelated user edits.
3. Add focused tests under `tests/gateway/` or the relevant module when practical.
4. Verify at least:
   - `python3 -m py_compile <changed python files>`
   - `uv run --extra dev pytest <focused tests>`
5. Commit and push to Jacob's fork:
   - `git -C ~/.hermes/hermes-agent add <files>`
   - `git -C ~/.hermes/hermes-agent commit -m "..."`
   - `git -C ~/.hermes/hermes-agent push`
6. Restart the gateway:
   - `launchctl kickstart -k gui/$(id -u)/ai.hermes.gateway`
   - verify `state = running` and new `pid`.
7. Check recent logs for `Traceback`, `ERROR`, and the feature-specific log lines.
8. Update GBrain `truth/agent-stack.md` with the new commit and behavior, then sync/embed/push `~/brain`.

## Config and Dotfiles Backups

Back up only public-safe config to `~/dotfiles`:

- `~/.codex/config.toml` -> `~/dotfiles/.codex/config.toml`
- this skill -> `~/dotfiles/.codex/skills/hermes-ops/SKILL.md`
- `~/.hermes/config.yaml` -> `~/dotfiles/.hermes/config.yaml`, but redact personal channel IDs or sensitive values
- `~/.hermes/SOUL.md` -> `~/dotfiles/.hermes/SOUL.md`
- `~/.hermes/skins/goku.yaml` -> `~/dotfiles/.hermes/skins/goku.yaml`
- launch agents -> `~/dotfiles/Library/LaunchAgents/`

Do not stage unrelated dirty dotfiles unless Jacob asked.

## Current Behavioral Expectations

- Goku runs primarily through WhatsApp.
- BlueBubbles is removed and should not be reintroduced unless Jacob explicitly asks.
- `xurl` is disabled; use browser automation for X.com unless Jacob re-enables paid API usage.
- Email/Workspace access is disabled; do not use Google Workspace, Gmail, Outlook, Microsoft Workspace, `gogcli`, or `himalaya` unless Jacob explicitly asks to re-enable and reauthenticate a specific capability.
- GBrain is the primary durable memory; built-in Hermes memory is quick recall only.
- WhatsApp replies create Apple Reminders notifications because WhatsApp self-chat does not reliably push notify.
