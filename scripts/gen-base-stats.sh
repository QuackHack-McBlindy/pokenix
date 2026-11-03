#!/usr/bin/env bash
set -euo pipefail
out="data/pokedex/base-stats.json"
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
