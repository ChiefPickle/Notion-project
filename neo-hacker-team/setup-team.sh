#!/bin/bash
# Neo Hacker Team — one-time setup helper
set -e

export PATH="/home/ubuntu/.local/bin:$PATH"

echo "⚔ Neo Hacker Team Setup"
echo ""

# Profiles (idempotent — skips if exists)
for p in neo cipher phantom specter shade; do
  if hermes profile show "$p" &>/dev/null; then
    echo "✓ Profile $p exists"
  else
    echo "→ Creating profile $p..."
    case $p in
      neo)     hermes profile create neo --description "Command & Control: routes missions from WhatsApp to the hacker team." ;;
      cipher)  hermes profile create cipher --description "Recon: OSINT and authorized target mapping." ;;
      phantom) hermes profile create phantom --description "Builder: scripts and PoCs on authorized targets." ;;
      specter) hermes profile create specter --description "Ops: terminal and infra on authorized systems." ;;
      shade)   hermes profile create shade --description "Audit: review and validate team output." ;;
    esac
  fi
done

hermes profile use neo
neo kanban init 2>/dev/null || true

echo ""
echo "✓ Team profiles ready"
echo ""
echo "Next steps:"
echo "  1. neo config set OPENROUTER_API_KEY sk-or-..."
echo "  2. neo whatsapp                    # scan QR"
echo "  3. neo config set WHATSAPP_ALLOWED_USERS YOUR_NUMBER"
echo "  4. neo gateway run"
echo ""
echo "See README.md for WhatsApp commands."
