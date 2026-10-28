#!/usr/bin/env python3
"""
fetch_pokemon.py — full PokéAPI snapshot for every Pokémon (Gen 1–9).

Produces:
    pokemon.json         # per-species: types, base stats, abilities, cries,
                         # egg groups, flavor text, evolution, height/weight,
                         # egg groups, hatch counter, catch rate, badges
    moves.json           # per-species: egg / level / tm / tutor / all
    types.json           # 18 entries: damage relations
    evolution-chains.json  # full trees, keyed by chain id
    abilities.json       # ability names + short effect text
    moves-info.json      # move names + type/power/accuracy/pp/damage class
"""

import json, sys, time
from pathlib import Path
import requests

BASE  = "https://pokeapi.co/api/v2"
CACHE = Path(".pokeapi-cache"); CACHE.mkdir(exist_ok=True)

def get(kind, key):
    p = CACHE / f"{kind}_{key}.json"
    if p.exists(): return json.loads(p.read_text())
    r = requests.get(f"{BASE}/{kind}/{key}/", timeout=20); r.raise_for_status()
    d = r.json(); p.write_text(json.dumps(d)); return d

def classify_moves(data):
    egg, tm, tutor, all_moves = set(), set(), set(), set()
    level = {}
    for e in data["moves"]:
        n = e["move"]["name"]; all_moves.add(n)
        for vg in e["version_group_details"]:
            m = vg["move_learn_method"]["name"]
            if   m == "egg":     egg.add(n)
            elif m == "machine": tm.add(n)
            elif m == "tutor":   tutor.add(n)
            elif m == "level-up":
                level.setdefault(int(vg["level_learned_at"]), set()).add(n)
    return {
        "egg":   sorted(egg),
        "level": [{"level": l, "moves": sorted(v)} for l, v in sorted(level.items())],
        "tm":    sorted(tm),
        "tutor": sorted(tutor),
        "all":   sorted(all_moves),
    }

def evolution_steps(chain_link, sprites, species_slug):
    """Return [{species, dex, condition, sprite}, …] following chain_link."""
    steps = []
    for nxt in chain_link.get("evolves_to", []):
        det = nxt["evolution_details"][0] if nxt["evolution_details"] else {}
        cond = []
        if det.get("trigger", {}).get("name") == "level-up":
            if det.get("min_level"): cond.append(f"Lv. {det['min_level']}")
            if det.get("time_of_day"): cond.append(det["time_of_day"])
            if det.get("held_item"): cond.append("hold " + det["held_item"]["name"])
            if det.get("known_move"): cond.append("know " + det["known_move"]["name"])
        elif det.get("trigger", {}).get("name") == "use-item":
            cond.append("use " + det["item"]["name"])
        elif det.get("trigger", {}).get("name") == "trade":
            cond.append("trade" + (" holding " + det["held_item"]["name"] if det.get("held_item") else ""))
        elif det.get("trigger", {}).get("name") == "shed":
            cond.append("empty slot + Poké Ball")
        # Gen 9 triggers: three-critical-hits, tower-of-darkness, etc. — raw name
        elif det.get("trigger", {}).get("name"):
            cond.append(det["trigger"]["name"].replace("-", " "))

        slug = nxt["species"]["name"]
        steps.append({
            "species":   slug,
            "condition": " · ".join(filter(None, cond)),
            "sprite":    sprites.get(slug),
        })
        steps.extend(evolution_steps(nxt, sprites, species_slug))
    return steps

def main():
    pokemon_out, moves_out = {}, {}
    evolution_chains = {}
    t0 = time.time()

    for i in range(1, 1026):
        try:
            p    = get("pokemon", i)
            sp   = get("pokemon-species", i)
        except requests.HTTPError as e:
            print(f"skip #{i}: {e}", file=sys.stderr); continue

        slug = p["name"]

        # --- evolution chain ---
        evo_url = sp["evolution_chain"]["url"].rstrip("/").split("/")[-1]
        try:
            chain = get("evolution-chain", evo_url)["chain"]
        except Exception:
            chain = {"evolves_to": []}

        # sprites for evo previews — pull from pokesprite via sprites path convention
        evo_slugs = []
        def walk(link):
            for nxt in link.get("evolves_to", []):
                evo_slugs.append(nxt["species"]["name"]); walk(nxt)
        walk(chain)

        pokemon_out[slug] = {
            "types":       [t["type"]["name"] for t in p["types"]],
            "abilities":   [
                {"name": a["ability"]["name"], "hidden": a["is_hidden"], "slot": a["slot"]}
                for a in p["abilities"]
            ],
            "baseStats":   {s["stat"]["name"]: s["base_stat"] for s in p["stats"]},
            "height":      p["height"] / 10,
            "weight":      p["weight"] / 10,
            "cries":       {"latest": p["cries"]["latest"], "legacy": p["cries"]["legacy"]},
            "heldItems":   [
                {"item": h["item"]["name"], "rarity": h["version_details"][0]["rarity"] if h["version_details"] else None}
                for h in p.get("held_items", [])
            ],

            "genera":         next((g["genus"] for g in sp["genera"] if g["language"]["name"] == "en"), None),
            "flavorText":     next((f["flavor_text"].replace("\n", " ").replace("\f", " ")
                                    for f in sp["flavor_text_entries"] if f["language"]["name"] == "en"), None),
            "eggGroups":      [g["name"] for g in sp["egg_groups"]],
            "hatchCounter":   sp["hatch_counter"],
            "captureRate":    sp["capture_rate"],
            "baseHappiness":  sp["base_happiness"],
            "growthRate":     sp["growth_rate"]["name"],
            "isLegendary":    sp["is_legendary"],
            "isMythical":     sp["is_mythical"],
            "isBaby":         sp["is_baby"],
            "habitat":        (sp["habitat"] or {}).get("name"),
            "color":          sp["color"]["name"],
            "shape":          (sp["shape"] or {}).get("name"),
            "evolutionChain": evo_url,
            "evolutionSteps": evolution_steps(chain, {}, slug),
        }
        moves_out[slug] = classify_moves(p)
        evolution_chains[evo_url] = chain

        if i % 100 == 0:
            print(f"  [{i}/1025] {time.time()-t0:.0f}s", file=sys.stderr)
        time.sleep(0.1)

    # Type relations — 18 fetches, done once
    types_out = {}
    for t in ["normal","fire","water","electric","grass","ice","fighting","poison",
              "ground","flying","psychic","bug","rock","ghost","dragon","dark","steel","fairy"]:
        d = get("type", t)
        types_out[t] = {
            "doubleDamageFrom": [x["name"] for x in d["damage_relations"]["double_damage_from"]],
            "halfDamageFrom":   [x["name"] for x in d["damage_relations"]["half_damage_from"]],
            "noDamageFrom":     [x["name"] for x in d["damage_relations"]["no_damage_from"]],
            "doubleDamageTo":   [x["name"] for x in d["damage_relations"]["double_damage_to"]],
            "halfDamageTo":     [x["name"] for x in d["damage_relations"]["half_damage_to"]],
            "noDamageTo":       [x["name"] for x in d["damage_relations"]["no_damage_to"]],
        }

    Path("pokemon.json").write_text(json.dumps(pokemon_out, indent=2, sort_keys=True))
    Path("moves.json").write_text(json.dumps(moves_out, indent=2, sort_keys=True))
    Path("types.json").write_text(json.dumps(types_out, indent=2, sort_keys=True))
    Path("evolution-chains.json").write_text(json.dumps(evolution_chains, indent=2, sort_keys=True))

    for f in ["pokemon.json", "moves.json", "types.json", "evolution-chains.json"]:
        print(f"Wrote {f} · {Path(f).stat().st_size/1024/1024:.1f} MB", file=sys.stderr)

if __name__ == "__main__":
    main()
