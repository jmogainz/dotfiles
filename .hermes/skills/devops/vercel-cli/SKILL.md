---
name: vercel-cli
description: Deploy and manage Vercel projects through the local Vercel CLI using VERCEL_TOKEN from ~/.hermes/.env. Use for Vercel deploys, env vars, project linking, domains, logs, rollbacks, and inspecting deployments.
version: 1.0.0
author: Jacob Moore
license: MIT
metadata:
  hermes:
    tags: [vercel, deployment, nextjs, hosting, cli]
prerequisites:
  commands: [vercel]
  environment: [VERCEL_TOKEN]
---

# Vercel CLI

Use the installed `vercel` CLI for deployments and project management. Load secrets from `~/.hermes/.env`; never paste tokens into chat, commit them, or print them.

## Rules

1. Use `--token "$VERCEL_TOKEN"` for noninteractive commands.
2. Check project status before mutating: `vercel project ls`, `vercel link --yes`, `vercel env ls`.
3. For production deploys, run local build/tests first unless Jacob explicitly asks to deploy immediately.
4. For env vars, prefer `vercel env add NAME production --token "$VERCEL_TOKEN"` and pipe values from the local environment without echoing them.
5. Never upload `.env`, `.env.local`, cookies, browser profiles, session stores, or OAuth token files.
6. After deploy, report deployment URL, production URL, env vars configured by name only, and any pending manual DNS/Stripe settings.

## Common Commands

```bash
set -a; source ~/.hermes/.env; set +a
vercel whoami --token "$VERCEL_TOKEN"
vercel link --yes --token "$VERCEL_TOKEN"
vercel env ls --token "$VERCEL_TOKEN"
vercel deploy --prod --token "$VERCEL_TOKEN"
vercel logs <deployment-url> --token "$VERCEL_TOKEN"
```

## Env Var Pattern

```bash
set -a; source ~/.hermes/.env; set +a
printf '%s' "$STRIPE_SECRET_KEY" | vercel env add STRIPE_SECRET_KEY production --token "$VERCEL_TOKEN"
```

If a project is not linked, run `vercel link --yes --project <name> --token "$VERCEL_TOKEN"` from the project directory.
