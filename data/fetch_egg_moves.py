#!/usr/bin/env python3
"""
fetch_egg_moves.py — fetch every egg move for every Pokémon (Gen 1-9)
from PokéAPI and write a single egg-moves.json keyed by PokéAPI slug.

Usage:
    python3 scripts/fetch_egg_moves.py

Output:
    egg-moves.json    # { "bulbasaur": ["charm", "curse", …], "mr-mime": […], … }

Notes:
    - Caches each /pokemon/{id} response in .pokeapi-cache/ so re-runs are instant.
    - A move counts as an "egg move" if ANY version group marks it as learn-method = egg.
    - PokéAPI's fair-use limit is ~100 req/hour; the 0.1s delay + cache keeps you
      well under it in normal use. First run on a cold cache takes ~2 minutes.
"""

import json
import sys
import time
from pathlib import Path

import requests

BASE_URL  = "https://pokeapi.co/api/v2"
CACHE_DIR = Path(".pokeapi-cache")
OUTPUT    = Path("egg-moves.json")
MAX_ID    = 1025          # Gen 1 .. Gen 9 (1025 = Pecharunt)
DELAY     = 0.1           # seconds between live requests


def fetch(pokemon_id: int) -> dict:
    CACHE_DIR.mkdir(exist_ok=True)
    cache = CACHE_DIR / f"pokemon_{pokemon_id}.json"
    if cache.exists():
        return json.loads(cache.read_text())
    r = requests.get(f"{BASE_URL}/pokemon/{pokemon_id}/", timeout=15)
    r.raise_for_status()
    data = r.json()
    cache.write_text(json.dumps(data))
    return data


def egg_moves_of(data: dict) -> list[str]:
    """Return sorted egg moves for one Pokémon resource."""
    moves = set()
    for entry in data["moves"]:
        for vg in entry["version_group_details"]:
            if vg["move_learn_method"]["name"] == "egg":
                moves.add(entry["move"]["name"])
                break
    return sorted(moves)


def main() -> None:
    result: dict[str, list[str]] = {}
    t0 = time.time()

    for i in range(1, MAX_ID + 1):
        try:
            data = fetch(i)
        except requests.HTTPError as e:
            print(f"  #{i}: skipped ({e})", file=sys.stderr)
            continue

        eggs = egg_moves_of(data)
        if eggs:
            result[data["name"]] = eggs

        if i % 100 == 0:
            print(
                f"  [{i}/{MAX_ID}] {len(result)} species with egg moves "
                f"· {time.time() - t0:.0f}s",
                file=sys.stderr,
            )
        time.sleep(DELAY)

    OUTPUT.write_text(json.dumps(result, indent=2, sort_keys=True) + "\n")
    print(f"Wrote {OUTPUT} · {len(result)} species", file=sys.stderr)


if __name__ == "__main__":
    main()
