# Neo Hacker Team — WhatsApp Command & Control

Manage a team of 5 Hermes agents from WhatsApp. **Neo** receives your orders and delegates to specialists via Kanban.

## Team roster

| Agent | Codename | Role |
|-------|----------|------|
| Commander interface | **neo** | Receives missions, decomposes tasks, routes work |
| Recon | **cipher** | OSINT, research, attack surface mapping |
| Builder | **phantom** | Scripts, PoCs, tooling |
| Ops | **specter** | Terminal, servers, infra |
| Audit | **shade** | Review, validate, sign-off |

**Authorized use only** — your systems, lab VMs, bug bounty scope, or written pentest contracts.

## Quick setup

```bash
# 1. API key (OpenRouter or your provider)
neo config set OPENROUTER_API_KEY sk-or-your-key-here

# 2. Install messaging + WhatsApp bridge deps
cd /workspace/hermes-agent
source venv/bin/activate
uv pip install -e ".[messaging]"

# 3. Pair WhatsApp (scan QR with phone)
neo whatsapp

# 4. Set your phone number (country code, no +)
neo config set WHATSAPP_ENABLED true
neo config set WHATSAPP_MODE bot
neo config set WHATSAPP_ALLOWED_USERS YOUR_PHONE_NUMBER

# 5. Start gateway (neo profile)
neo gateway run
# or: neo gateway install && neo gateway start
```

## Give tasks from WhatsApp

**Natural language (Neo decomposes automatically):**
```
Mission: map the attack surface of our staging API at staging.example.com — authorized scope only
```

**Direct Kanban commands:**
```
/kanban create "Recon staging API" --assignee cipher --triage
/kanban list
/kanban show t_abc123
/kanban stats
```

**Assign to a specific agent:**
```
/kanban create "Write nmap wrapper script" --assignee phantom --body "Python script for authorized lab scans only"
```

## Monitor from WhatsApp

- `/kanban list` — all active missions
- `/kanban stats` — board summary
- Completion pings arrive automatically when subscribed tasks finish
- `/kanban comment <id> your feedback` — steer a worker
- `/kanban unblock <id>` — resume blocked tasks

## Dashboard (optional)

```bash
neo dashboard
# Open Kanban tab at http://127.0.0.1:9119
```

## Files

| Path | Purpose |
|------|---------|
| `~/.hermes/profiles/neo/SOUL.md` | Neo commander persona |
| `~/.hermes/profiles/*/SOUL.md` | Specialist personas |
| `~/.hermes/profiles/neo/config.yaml` | Kanban orchestration |
| `~/.hermes/kanban.db` | Shared task board |

## Example mission flow

1. You (WhatsApp): *"Mission: audit our GitHub repo for leaked secrets — repo is ours"*
2. Neo creates tasks: cipher (scan), phantom (fix scripts if needed), shade (review)
3. Workers run in parallel where possible
4. You get completion notifications on WhatsApp
5. Shade blocks for review if needed; you `/kanban unblock` to continue
