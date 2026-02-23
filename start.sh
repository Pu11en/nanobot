#!/bin/bash
set -e

# Generate config from env vars
cat > /root/.nanobot/config.json << EOF
{
  "providers": {
    "anthropic": {
      "apiKey": "${ANTHROPIC_API_KEY}"
    }
  },
  "agents": {
    "defaults": {
      "model": "anthropic/claude-sonnet-4-20250514"
    }
  },
  "channels": {
    "telegram": {
      "enabled": ${TELEGRAM_ENABLED:-false},
      "token": "${TELEGRAM_BOT_TOKEN:-}",
      "allowFrom": ${TELEGRAM_ALLOW_FROM:-[]}
    }
  },
  "gateway": {
    "host": "0.0.0.0",
    "port": ${PORT:-18790}
  }
}
EOF

echo "Config generated:"
cat /root/.nanobot/config.json

exec nanobot gateway
