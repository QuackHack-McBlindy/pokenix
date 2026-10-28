#!/usr/bin/env python3
"""
fetch_move_info.py — metadata for every move referenced on the site.
Writes move-info.json: { "close-combat": { name, type, damageClass, power,
accuracy, pp, effect }, … }
"""

import json, sys, time
from pathlib import Path
import requests

BASE  = "https://pokeapi.co/api/v2"
CACHE = Path(".pokeapi-cache"); CACHE.mkdir(exist_ok=True)
OUT   = Path("move-info.json")

def get(kind, key):
    p = CACHE / f"{kind}_{key}.json"
    if p.exists(): return json.loads(p.read_text())
    r = requests.get(f"{BASE}/{kind}/{key}/", timeout=20); r.raise_for_status()
    d = r.json(); p.write_text(json.dumps(d)); return d

def prettify(slug):
    return " ".join(w.capitalize() for w in slug.split("-"))

def short_effect(data):
    for e in data["effect_entries"]:
        if e["language"]["name"] == "en":
            txt = e["short_effect"]
            txt = txt.replace("$effect_chance", str(data.get("effect_chance") or ""))
            return txt.strip()
    return ""

def main():
    r = requests.get(f"{BASE}/move?limit=2000", timeout=20); r.raise_for_status()
    slugs = [m["name"] for m in r.json()["results"]]
    out = {}
    t0 = time.time()
    for i, slug in enumerate(slugs, 1):
        try: d = get("move", slug)
        except Exception as e: print(f"skip {slug}: {e}", file=sys.stderr); continue
        out[slug] = {
            "name":        prettify(slug),
            "type":        d["type"]["name"],
            "damageClass": d["damage_class"]["name"],
            "power":       d["power"],
            "accuracy":    d["accuracy"],
            "pp":          d["pp"],
            "effect":      short_effect(d),
        }
        if i % 100 == 0:
            print(f"  [{i}/{len(slugs)}] {time.time()-t0:.0f}s", file=sys.stderr)
        time.sleep(0.1)
    OUT.write_text(json.dumps(out, indent=2, sort_keys=True) + "\n")
    print(f"Wrote {OUT} · {len(out)} moves · {OUT.stat().st_size/1024:.0f} KB", file=sys.stderr)

if __name__ == "__main__":
    main()
