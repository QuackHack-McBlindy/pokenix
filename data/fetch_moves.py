#!/usr/bin/env python3
"""
fetch_moves.py — fetch every learnable move for every Pokémon (Gen 1–9)
from PokéAPI and write a single moves.json keyed by PokéAPI slug.

Output shape per species:
    {
      "egg":   ["charm", "curse", …],                    # sorted
      "level": [ {"level": 1, "moves": ["tackle", …]},   # sorted by level
                 {"level": 3, "moves": ["vine-whip"]}, …],
      "tm":    ["toxic", …],                              # sorted
      "tutor": ["giga-drain", …],                         # sorted
      "all":   ["…"]                                      # union, sorted
    }

Usage:
    python3 scripts/fetch_moves.py

The 1025 requests are cached in .pokeapi-cache/ so re-runs are instant.
First cold run: ~2 minutes (0.1s delay keeps you well under PokéAPI's
fair-use limit).
"""

import json
import sys
import time
from pathlib import Path

import requests

BASE_URL  = "https://pokeapi.co/api/v2"
CACHE_DIR = Path(".pokeapi-cache")
OUTPUT    = Path("moves.json")
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


def classify(data: dict) -> dict:
    egg, tm, tutor, all_moves = set(), set(), set(), set()
    level: dict[int, set[str]] = {}

    for entry in data["moves"]:
        name = entry["move"]["name"]
        all_moves.add(name)
        for vg in entry["version_group_details"]:
            method = vg["move_learn_method"]["name"]
            if method == "egg":
                egg.add(name)
            elif method == "machine":
                tm.add(name)
            elif method == "tutor":
                tutor.add(name)
            elif method == "level-up":
                lvl = int(vg["level_learned_at"])
                level.setdefault(lvl, set()).add(name)

    return {
        "egg":   sorted(egg),
        "level": [
            {"level": lvl, "moves": sorted(moves)}
            for lvl, moves in sorted(level.items())
        ],
        "tm":    sorted(tm),
        "tutor": sorted(tutor),
        "all":   sorted(all_moves),
    }


def main() -> None:
    result: dict[str, dict] = {}
    t0 = time.time()

    for i in range(1, MAX_ID + 1):
        try:
            data = fetch(i)
        except requests.HTTPError as e:
            print(f"  #{i}: skipped ({e})", file=sys.stderr)
            continue

        info = classify(data)
        if info["all"]:
            result[data["name"]] = info

        if i % 100 == 0:
            print(
                f"  [{i}/{MAX_ID}] {len(result)} species · {time.time() - t0:.0f}s",
                file=sys.stderr,
            )
        time.sleep(DELAY)

    OUTPUT.write_text(json.dumps(result, indent=2, sort_keys=True) + "\n")
    size_mb = OUTPUT.stat().st_size / 1024 / 1024
    print(
        f"Wrote {OUTPUT} · {len(result)} species · {size_mb:.1f} MB",
        file=sys.stderr,
    )


if __name__ == "__main__":
    main()
