#!/usr/bin/env bash
# Round-trip test:
#  1. Dhall → YAML via dhall-to-yaml --omit-empty
#  2. Dhall-derived YAML  → PNG via awsdac
#  3. Upstream YAML        → PNG via awsdac
#  4. Compare PNGs byte-for-byte
#
# Also runs `dhall type` against schema/Diagram.dhall and `dhall hash`
# against package.dhall to catch schema drift in CI.
#
# Requires: dhall, dhall-to-yaml, awsdac, cmp on PATH.
set -euo pipefail

cd "$(dirname "$0")/.."

if command -v dhall-to-yaml >/dev/null 2>&1; then
  DHALL_TO_YAML=dhall-to-yaml
elif command -v dhall-to-yaml-ng >/dev/null 2>&1; then
  DHALL_TO_YAML=dhall-to-yaml-ng
else
  echo "error: dhall-to-yaml (or dhall-to-yaml-ng) not found on PATH" >&2
  exit 1
fi

AWSDAC="${AWSDAC:-awsdac}"
if ! command -v "$AWSDAC" >/dev/null 2>&1 && [ ! -x "$AWSDAC" ]; then
  echo "error: awsdac not found (set \$AWSDAC to override)" >&2
  exit 1
fi

DHALL_DIR=examples
UPSTREAM_DIR=diagram-as-code/examples
OUT=$(mktemp -d)
trap 'rm -rf "$OUT"' EXIT

pairs=(
  "alb-ec2"
  "vpc-natgw"
)

echo "==> Type-checking package..."
dhall type --file package.dhall > /dev/null
echo "==> Schema hash:"
dhall hash --file package.dhall

fail=0
for name in "${pairs[@]}"; do
  echo "==> $name"
  dhall_src="$DHALL_DIR/$name.dhall"
  upstream_yaml="$UPSTREAM_DIR/$name.yaml"

  dhall_yaml="$OUT/$name.dhall.yaml"
  dhall_png="$OUT/$name.dhall.png"
  upstream_png="$OUT/$name.upstream.png"

  "$DHALL_TO_YAML" --omit-empty --file "$dhall_src" > "$dhall_yaml"
  "$AWSDAC" -f "$dhall_yaml" -o "$dhall_png"
  "$AWSDAC" -f "$upstream_yaml" -o "$upstream_png"

  if cmp -s "$dhall_png" "$upstream_png"; then
    echo "    PASS  $name"
  else
    echo "    FAIL  $name (PNG mismatch)"
    fail=1
  fi
done

exit "$fail"
