---
name: apple-reminders
description: "Apple Reminders via remindctl: add, list, complete. Use for Jacob's personal 'remind me', same-day, clock-time, and iPhone/iCloud reminder requests."
version: 1.0.0
author: Hermes Agent
license: MIT
platforms: [macos]
metadata:
  hermes:
    tags: [Reminders, tasks, todo, macOS, Apple]
prerequisites:
  commands: [remindctl]
---

# Apple Reminders

Use `remindctl` to manage Apple Reminders directly from the terminal. Tasks sync across all Apple devices via iCloud.

## Prerequisites

- **macOS** with Reminders.app
- Install: `brew install steipete/tap/remindctl`
- Grant Reminders permission when prompted
- Check: `remindctl status` / Request: `remindctl authorize`

## When to Use

- User mentions "reminder" or "Reminders app"
- Jacob says "remind me", "set a reminder", "make me reminders", or asks for one-off reminders at specific times
- Creating personal to-dos with due dates that sync to iOS
- Managing Apple Reminders lists
- User wants tasks to appear on their iPhone/iPad

## When NOT to Use

- Scheduling agent-internal alerts, reports, or automation loops → use the cronjob tool instead
- Sending reminders to another person or platform → use the appropriate messaging/scheduler workflow
- Calendar events → use Apple Calendar or Google Calendar
- Project task management → use GitHub Issues, Notion, etc.
- If "remind me" is ambiguous between a native personal reminder and an agent workflow, choose Apple Reminders for user-facing personal reminders and clarify only when the request implies an agent job/report

## Quick Reference

### View Reminders

```bash
remindctl                    # Today's reminders
remindctl today              # Today
remindctl tomorrow           # Tomorrow
remindctl week               # This week
remindctl overdue            # Past due
remindctl all                # Everything
remindctl 2026-01-04         # Specific date
```

### Manage Lists

```bash
remindctl list               # List all lists
remindctl list Work          # Show specific list
remindctl list Projects --create    # Create list
remindctl list Work --delete        # Delete list
```

### Create Reminders

```bash
remindctl add "Buy milk"
remindctl add --title "Call mom" --list Personal --due tomorrow
remindctl add --title "Meeting prep" --due "2026-02-15 09:00"
```

### Complete / Delete

```bash
remindctl complete 1 2 3          # Complete by ID
remindctl delete 4A83 --force     # Delete by ID
```

### Output Formats

```bash
remindctl today --json       # JSON for scripting
remindctl today --plain      # TSV format
remindctl today --quiet      # Counts only
```

## Date Formats

Accepted by `--due` and date filters:
- `today`, `tomorrow`, `yesterday`
- `YYYY-MM-DD`
- `YYYY-MM-DD HH:mm`
- ISO 8601 (`2026-01-04T12:34:56Z`)

## Rules

1. For Jacob's personal "remind me" / "reminder to myself" / same-day clock-time requests, always default to Apple Reminders because it syncs to Jacob's iPhone through iCloud.
2. Do not use Hermes cron for personal reminders just because the prompt says "schedule" or includes a clock time. Use cron only for agent-internal jobs, reports, recurring automation, or reminders to other people/platforms.
3. Clarify only when the request sounds like an agent-internal scheduled job/report rather than a user-facing reminder.
4. If Jacob gives the reminder content and exact time/date, create it directly without an extra confirmation, then verify it exists before saying done.
5. Use the default `Reminders` list unless Jacob names another Reminders list.
6. Use `--json` for programmatic parsing.
