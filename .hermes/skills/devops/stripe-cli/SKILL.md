---
name: stripe-cli
description: Manage Stripe products, prices, checkout sessions, webhooks, and local Stripe testing through the Stripe CLI or Stripe SDK using STRIPE_SECRET_KEY/STRIPE_API_KEY from ~/.hermes/.env. Use for payment setup, Checkout debugging, webhook forwarding, and Stripe product configuration.
version: 1.0.0
author: Jacob Moore
license: MIT
metadata:
  hermes:
    tags: [stripe, payments, checkout, webhooks, cli]
prerequisites:
  commands: [stripe]
  environment: [STRIPE_SECRET_KEY]
---

# Stripe CLI

Use local Stripe credentials from `~/.hermes/.env`. `STRIPE_API_KEY` and `STRIPE_SECRET_KEY` may be aliases for the same secret. Never print secret keys, webhook secrets, customer PII, card data, or raw event payloads unless Jacob explicitly asks for redacted debug output.

## Rules

1. Prefer test mode until Jacob explicitly confirms production/live mode.
2. Create stable products/prices for sellable products instead of inline prices when product naming matters.
3. Confirm before destructive actions, refunds, cancellations, or changes to live prices.
4. Use Stripe-hosted Checkout for simple paid downloads.
5. For webhooks, store `STRIPE_WEBHOOK_SECRET` locally and in Vercel env; do not commit it.
6. Report product IDs, price IDs, and checkout/session IDs; these are not secrets. Do not report secret keys.

## Common Commands

```bash
set -a; source ~/.hermes/.env; set +a
stripe --api-key "$STRIPE_SECRET_KEY" products list --limit 5
stripe --api-key "$STRIPE_SECRET_KEY" prices list --limit 5
stripe --api-key "$STRIPE_SECRET_KEY" listen --forward-to localhost:3000/api/stripe/webhook
```

## SDK Pattern

For operations that are awkward in the CLI, use a short Node script with the `stripe` package already installed in the app:

```bash
set -a; source ~/.hermes/.env; set +a
node scripts/stripe-task.mjs
```

Keep scripts idempotent: look up an existing product/price by name or metadata before creating duplicates.
