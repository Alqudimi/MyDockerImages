#!/usr/bin/env bash
set -euo pipefail
BASE_URL="${BASE_URL:-http://127.0.0.1:8080}"

curl --fail --silent --show-error "$BASE_URL/health" >/dev/null
curl --fail --silent --show-error "$BASE_URL/v1/models" | grep -q 'Qwen3-0.6B-Q4_K_M.gguf'
curl --fail --silent --show-error "$BASE_URL/v1/chat/completions" \\
  -H 'Content-Type: application/json' \\
  -H 'Authorization: Bearer sk-local' \\
  -d '{"model":"Qwen3-0.6B-Q4_K_M.gguf","messages":[{"role":"user","content":"Reply with exactly: OK"}],"max_tokens":8,"temperature":0,"stream":false}' \\
  | grep -q 'choices'
printf 'OpenAI-compatible API smoke test: PASS\n'
