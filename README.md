# Mortal Kombat Context Bar for Claude Code

A Mortal Kombat-inspired health bar status line for [Claude Code](https://claude.ai/claude-code) that shows how much context window you have remaining.

## Preview

```
Opus 4.6 // FIGHT!   █████████████████░░░ 85% HP | $0.42
Opus 4.6 // WOUNDED   ████████░░░░░░░░░░░░ 40% HP | $1.87
Opus 4.6 // CRITICAL  ████░░░░░░░░░░░░░░░░ 20% HP | $3.21
Opus 4.6 // DANGER    █░░░░░░░░░░░░░░░░░░░  5% HP | $5.50
```

## Health Stages

| Remaining | Label      | Color  |
|-----------|------------|--------|
| > 50%     | **FIGHT!** | Green  |
| 25–50%    | **WOUNDED**| Yellow |
| 10–25%    | **CRITICAL**| Red   |
| < 10%     | **DANGER** | Red    |

## Install

1. Copy the script:

```bash
cp statusline.sh ~/.claude/statusline.sh
chmod +x ~/.claude/statusline.sh
```

2. Add to `~/.claude/settings.json`:

```json
{
  "statusLine": {
    "type": "command",
    "command": "~/.claude/statusline.sh"
  }
}
```

That's it. The bar appears at the bottom of your Claude Code terminal on the next interaction.

## Requirements

- [Claude Code](https://claude.ai/claude-code)
- `jq` (for parsing JSON input)

## License

MIT
