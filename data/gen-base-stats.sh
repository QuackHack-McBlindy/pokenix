#!/usr/bin/env bash
# Generates data/base-stats.json from PokéAPI.
# Stats order per entry: [hp, atk, def, spa, spd, spe]
set -euo pipefail
out="data/base-stats.json"
tmp=$(mktemp)
echo "{" > "$tmp"
last=1025
for id in $(seq 1 "$last"); do
  stats=$(curl -sf "https://pokeapi.co/api/v2/pokemon/$id" \
    | jq -c '[.stats[] | .base_stat]')
  comma=","
  [ "$id" = "$last" ] && comma=""
  printf '  "%s": %s%s\n' "$id" "$stats" "$comma" >> "$tmp"
  printf 'fetched %s\r' "$id" >&2
done
echo "" >> "$tmp"
echo "}" >> "$tmp"
mv "$tmp" "$out"
echo "" >&2
echo "wrote $out" >&2
