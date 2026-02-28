#!/bin/bash
set -euo pipefail

# Only run in remote Claude Code on the web sessions
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

# Pre-cache n8n-mcp package so it's immediately available for MCP server startup.
# n8n-mcp runs as a stdio MCP server; we send EOF via /dev/null so it exits quickly
# after initialization and the package gets cached by npx.
echo "Pre-caching n8n-mcp..."
timeout 15 npx -y n8n-mcp < /dev/null 2>/dev/null || true

echo "n8n-mcp setup complete."
