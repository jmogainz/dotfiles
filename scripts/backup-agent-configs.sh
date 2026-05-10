#!/usr/bin/env bash
set -euo pipefail

home="${HOME}"
dotfiles="${home}/dotfiles"

install -d \
  "${dotfiles}/.codex/skills/hermes-ops" \
  "${dotfiles}/.hermes/skills/apple/apple-reminders" \
  "${dotfiles}/.hermes/skins" \
  "${dotfiles}/Library/LaunchAgents"

cp "${home}/.codex/config.toml" "${dotfiles}/.codex/config.toml"
perl -0pi -e 's#set = \{ PATH = "[^"]+" \}#set = { PATH = "/Users/jmogainz/.bun/bin:/Users/jmogainz/.local/bin:/Users/jmogainz/go/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin" }#' \
  "${dotfiles}/.codex/config.toml"
cp "${home}/.codex/skills/hermes-ops/SKILL.md" "${dotfiles}/.codex/skills/hermes-ops/SKILL.md"

cp "${home}/.hermes/config.yaml" "${dotfiles}/.hermes/config.yaml"
perl -0pi -e 's/WHATSAPP_HOME_CHANNEL:\s*\S+/WHATSAPP_HOME_CHANNEL: "<redacted-whatsapp-home-channel>"/g' \
  "${dotfiles}/.hermes/config.yaml"

cp "${home}/.hermes/SOUL.md" "${dotfiles}/.hermes/SOUL.md"
cp "${home}/.hermes/skills/apple/apple-reminders/SKILL.md" \
  "${dotfiles}/.hermes/skills/apple/apple-reminders/SKILL.md"
cp "${home}/.hermes/skins/goku.yaml" "${dotfiles}/.hermes/skins/goku.yaml"

cp "${home}/Library/LaunchAgents/ai.hermes.gateway.plist" \
  "${dotfiles}/Library/LaunchAgents/ai.hermes.gateway.plist"
perl -0pi -e 's#<key>PATH</key>\s*<string>[^<]+</string>#<key>PATH</key>\n        <string>/Users/jmogainz/.hermes/hermes-agent/venv/bin:/Users/jmogainz/.hermes/hermes-agent/node_modules/.bin:/Users/jmogainz/.bun/bin:/Users/jmogainz/.local/bin:/Users/jmogainz/go/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin</string>#' \
  "${dotfiles}/Library/LaunchAgents/ai.hermes.gateway.plist"
cp "${home}/Library/LaunchAgents/ai.hermes.chrome-cdp.plist" \
  "${dotfiles}/Library/LaunchAgents/ai.hermes.chrome-cdp.plist"
cp "${home}/Library/LaunchAgents/com.gbrain.autopilot.plist" \
  "${dotfiles}/Library/LaunchAgents/com.gbrain.autopilot.plist"

echo "Backed up public-safe Codex/Hermes/GBrain config snapshots to ${dotfiles}."
