#!/usr/bin/env python3
"""
fetch_data.py — Fetch Pokémon and Pokédex data from PokéAPI.
"""

import json, sys, time
from pathlib import Path
import requests

BASE  = "https://pokeapi.co/api/v2"
PROJECT_ROOT = Path(__file__).resolve().parent.parent
DATA_DIR = PROJECT_ROOT / "data" / "pokedex"
CACHE = PROJECT_ROOT / ".pokeapi-cache"

DATA_DIR.mkdir(parents=True, exist_ok=True)
CACHE.mkdir(parents=True, exist_ok=True)

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

def evolution_steps(chain_link):
    """Return [{species, condition}, …] for the evolution chain."""
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

        elif det.get("trigger", {}).get("name"):
            cond.append(det["trigger"]["name"].replace("-", " "))

        slug = nxt["species"]["name"]
        steps.append({
            "species": slug,
            "condition": " · ".join(filter(None, cond)),
        })
        steps.extend(evolution_steps(nxt))
    return steps

HELD_CATEGORIES = {
    "held-items",
    "choice",
    "bad-held-items",
    "type-enhancement",
    "type-protection",
    "plates",
    "memories",
    "mega-stones",
    "z-crystals",
    "species-specific",
    "scarves",
    "jewels",
    "in-a-pinch",
    "picky-healing",
    "effort-training",
    "effort-drop",
    "stat-boosts",
}


def fetch_items(t0):
    """Fetch held-item metadata from PokéAPI.

    Uses /item-category/{name} endpoints to filter by category BEFORE
    fetching each item's full details, so we make ~250 requests instead
    of 2223. Every field is read with .get() so a stale cached 404 body
    can't crash the run.
    """
    print("Fetching item categories…", file=sys.stderr)
    r = requests.get(f"{BASE}/item-category?limit=100", timeout=20)
    r.raise_for_status()
    all_categories = r.json()["results"]
    print(f"  {len(all_categories)} categories found", file=sys.stderr)

    item_names = set()
    for cat in all_categories:
        if cat["name"] not in HELD_CATEGORIES:
            continue
        try:
            cat_data = get("item-category", cat["name"])
        except requests.HTTPError as e:
            print(f"  skip category {cat['name']}: {e}", file=sys.stderr)
            continue
        for item in cat_data.get("items", []):
            item_names.add(item["name"])

    print(f"  {len(item_names)} held items to fetch", file=sys.stderr)

    out = {}
    for i, name in enumerate(sorted(item_names), 1):
        try:
            d = get("item", name)
        except requests.HTTPError as e:
            print(f"  skip item {name}: {e}", file=sys.stderr)
            continue

        if not isinstance(d, dict) or "name" not in d:
            print(f"  skip item {name}: not a valid response", file=sys.stderr)
            continue

        def english(entries, key="effect"):
            for e in entries:
                if e.get("language", {}).get("name") == "en":
                    return e.get(key)
            return None

        out[name] = {
            "id":          d.get("id"),
            "name":        d.get("name", name),
            "cost":        d.get("cost"),
            "flingPower":  d.get("fling_power"),
            "flingEffect": (d.get("fling_effect") or {}).get("name"),
            "category":    (d.get("category") or {}).get("name"),
            "attributes":  [a["name"] for a in d.get("attributes", [])],
            "effect":      english(d.get("effect_entries", []), "effect"),
            "shortEffect": english(d.get("effect_entries", []), "short_effect"),
            "flavorText":  english(d.get("flavor_text_entries", []), "text"),
            "sprite":      (d.get("sprites") or {}).get("default"),
            "names": {
                n["language"]["name"]: n["name"]
                for n in d.get("names", [])
            },
        }

        if i % 50 == 0:
            print(f"  [{i}/{len(item_names)}] items · {time.time()-t0:.0f}s",
                  file=sys.stderr)
        time.sleep(0.05)

    return out
    
    
    

def fetch_move_info(t0):
    """Fetch metadata for every move. Returns a slug-keyed dict."""
    print("Fetching move list…", file=sys.stderr)
    r = requests.get(f"{BASE}/move?limit=2000", timeout=20)
    r.raise_for_status()
    slugs = [m["name"] for m in r.json()["results"]]
    print(f"  {len(slugs)} moves found — fetching details…", file=sys.stderr)

    out = {}
    for i, slug in enumerate(slugs, 1):
        try:
            d = get("move", slug)
        except requests.HTTPError as e:
            print(f"  skip move {slug}: {e}", file=sys.stderr)
            continue

        short = ""
        for e in d.get("effect_entries", []):
            if e["language"]["name"] == "en":
                short = e["short_effect"].replace(
                    "$effect_chance", str(d.get("effect_chance") or "")
                ).strip()
                break

        out[slug] = {
            "name":        " ".join(w.capitalize() for w in slug.split("-")),
            "type":        d["type"]["name"],
            "damageClass": d["damage_class"]["name"],
            "power":       d["power"],
            "accuracy":    d["accuracy"],
            "pp":          d["pp"],
            "effect":      short,
        }

        if i % 100 == 0:
            print(f"  [{i}/{len(slugs)}] moves · {time.time()-t0:.0f}s",
                  file=sys.stderr)
        time.sleep(0.1)

    return out


def fetch_shiny_list(t0):
    """Generate both shiny living-dex lists in a single pass.

    Returns (gender_diff, national) where each is a list of
    {name, slug, gender, dex, sprite} dicts.

    gender_diff: full dex + gender-difference splits + all alternate forms
    national:    one entry per species (default variety only), no splits
    """
    print("Generating shiny living-dex lists…", file=sys.stderr)
    gender_diff = []
    national    = []

    for i in range(1, 1026):
        try:
            sp = get("pokemon-species", i)
        except requests.HTTPError as e:
            print(f"  skip species #{i}: {e}", file=sys.stderr)
            continue

        species = sp["name"]

        for variety in sp["varieties"]:
            variety_name = variety["pokemon"]["name"]
            variety_id   = int(variety["pokemon"]["url"].rstrip("/").split("/")[-1])

            try:
                pf = get("pokemon", variety_id)
            except requests.HTTPError as e:
                print(f"  skip variety {variety_name}: {e}", file=sys.stderr)
                continue

            sprites = pf.get("sprites") or {}
            male    = sprites.get("front_shiny") or ""
            female  = sprites.get("front_shiny_female") or ""

            if not male:
                continue

            if variety["is_default"]:
                national.append({
                    "name":   species,
                    "slug":   variety_name,
                    "gender": None,
                    "dex":    i,
                    "sprite": male,
                })

            is_gender_variant = variety_name.endswith(("-male", "-female"))

            if is_gender_variant:
                gender_diff.append({
                    "name":   species,
                    "slug":   variety_name,
                    "gender": None,
                    "dex":    i,
                    "sprite": male,
                })
            elif female:
                gender_diff.append({
                    "name":   species,
                    "slug":   f"{species}-m",
                    "gender": "male",
                    "dex":    i,
                    "sprite": male,
                })
                gender_diff.append({
                    "name":   species,
                    "slug":   f"{species}-f",
                    "gender": "female",
                    "dex":    i,
                    "sprite": female,
                })
            else:
                gender_diff.append({
                    "name":   species,
                    "slug":   variety_name,
                    "gender": None,
                    "dex":    i,
                    "sprite": male,
                })

        if i % 100 == 0:
            print(
                f"  [{i}/1025] · gender-diff: {len(gender_diff)} "
                f"· national: {len(national)} · {time.time()-t0:.0f}s",
                file=sys.stderr,
            )
        time.sleep(0.05)

    def dedupe(entries):
        seen, out = set(), []
        for e in entries:
            if e["slug"] not in seen:
                seen.add(e["slug"])
                out.append(e)
        return out

    gender_diff = dedupe(gender_diff)
    national    = dedupe(national)

    split_count = sum(1 for e in gender_diff if e["gender"] is not None)
    print(f"  gender-diff: {len(gender_diff)} entries "
          f"({split_count} gender-split, {len(gender_diff) - split_count} single)",
          file=sys.stderr)
    print(f"  national:    {len(national)} entries", file=sys.stderr)

    return gender_diff, national

def fetch_abilities(t0):
    """Fetch metadata for every ability. Returns a slug-keyed dict."""
    print("Fetching ability list…", file=sys.stderr)
    r = requests.get(f"{BASE}/ability?limit=1000", timeout=20)
    r.raise_for_status()
    slugs = [a["name"] for a in r.json()["results"]]
    print(f"  {len(slugs)} abilities found — fetching details…", file=sys.stderr)

    out = {}
    for i, slug in enumerate(slugs, 1):
        try:
            d = get("ability", slug)
        except requests.HTTPError as e:
            print(f"  skip ability {slug}: {e}", file=sys.stderr)
            continue

        effect = short = ""
        for e in d.get("effect_entries", []):
            if e["language"]["name"] == "en":
                effect = e["effect"].strip()
                short  = e["short_effect"].strip()
                break

        flavor = ""
        for f in d.get("flavor_text_entries", []):
            if f["language"]["name"] == "en":
                flavor = f["flavor_text"].replace("\n", " ").replace("\f", " ").strip()
                break

        display = slug
        for n in d.get("names", []):
            if n["language"]["name"] == "en":
                display = n["name"]
                break

        out[slug] = {
            "name":          display,
            "isMainSeries":  d["is_main_series"],
            "generation":    d["generation"]["name"],
            "effect":        effect,
            "shortEffect":   short,
            "flavorText":    flavor,
            "pokemon": [
                {
                    "name":     p["pokemon"]["name"],
                    "isHidden": p["is_hidden"],
                    "slot":     p["slot"],
                }
                for p in d.get("pokemon", [])
            ],
        }

        if i % 100 == 0:
            print(f"  [{i}/{len(slugs)}] abilities · {time.time()-t0:.0f}s",
                  file=sys.stderr)
        time.sleep(0.05)

    return out    

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

        evo_url = sp["evolution_chain"]["url"].rstrip("/").split("/")[-1]
        try:
            chain = get("evolution-chain", evo_url)["chain"]
        except Exception:
            chain = {"evolves_to": []}

        evo_slugs = []
        def walk(link):
            for nxt in link.get("evolves_to", []):
                evo_slugs.append(nxt["species"]["name"]); walk(nxt)
        walk(chain)

        pokemon_out[slug] = {
            "dexNumber": next(
                (
                    entry["entry_number"]
                    for entry in sp["pokedex_numbers"]
                    if entry["pokedex"]["name"] == "national"
                ),
                None,
            ),

            "genderRate": sp["gender_rate"],
            "generation": sp["generation"]["name"],
            "hasGenderDifferences": sp["has_gender_differences"],
            "formsSwitchable": sp["forms_switchable"],

            "evolvesFromSpecies": (
                sp["evolves_from_species"]["name"]
                if sp["evolves_from_species"] is not None
                else None
            ),

            "varieties": [
                {
                    "isDefault": variety["is_default"],
                    "pokemon": variety["pokemon"]["name"],
                    "url": variety["pokemon"]["url"],
                }
                for variety in sp["varieties"]
            ],

            "pokedexNumbers": [
                {
                    "pokedex": entry["pokedex"]["name"],
                    "number": entry["entry_number"],
                }
                for entry in sp["pokedex_numbers"]
            ],

            "names": [
                {
                    "name": entry["name"],
                    "language": entry["language"]["name"],
                }
                for entry in sp["names"]
            ],

            "formDescriptions": [
                {
                    "description": entry["description"],
                    "language": entry["language"]["name"],
                }
                for entry in sp["form_descriptions"]
            ],

            "palParkEncounters": [
                {
                    "area": entry["area"]["name"],
                    "baseScore": entry["base_score"],
                    "rate": entry["rate"],
                }
                for entry in sp["pal_park_encounters"]
            ],

            "baseExperience": p["base_experience"],
            "isDefault": p["is_default"],
            "order": p["order"],

            "pastTypes": p["past_types"],
            "pastAbilities": p["past_abilities"],
            "pastStats": p["past_stats"],

            "gameIndices": [
                {
                    "gameIndex": entry["game_index"],
                    "version": entry["version"]["name"],
                }
                for entry in p["game_indices"]
            ],

            "sprites": p["sprites"],

            "forms": [
                {
                    "name": form["name"],
                    "url": form["url"],
                }
                for form in p["forms"]
            ],

            "locationAreaEncounters": p["location_area_encounters"],

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
            "evolutionSteps": evolution_steps(chain),
        }
        moves_out[slug] = classify_moves(p)
        evolution_chains[evo_url] = chain

        if i % 100 == 0:
            print(f"  [{i}/1025] {time.time()-t0:.0f}s", file=sys.stderr)
        time.sleep(0.1)



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

    abilities_out = fetch_abilities(t0)
    (DATA_DIR / "abilities.json").write_text(
        json.dumps(abilities_out, indent=2, sort_keys=True)
    )

    shiny_gd, shiny_nat = fetch_shiny_list(t0)
    (DATA_DIR / "shiny-gender-diff.json").write_text(
        json.dumps({"shiny": shiny_gd}, indent=2, sort_keys=True) + "\n"
    )
    (DATA_DIR / "shiny-national.json").write_text(
        json.dumps({"shiny": shiny_nat}, indent=2, sort_keys=True) + "\n"
    )

    move_info_out = fetch_move_info(t0)
    (DATA_DIR / "move-info.json").write_text(
        json.dumps(move_info_out, indent=2, sort_keys=True)
    )

    items_out = fetch_items(t0)
    (DATA_DIR / "items.json").write_text(
        json.dumps(items_out, indent=2, sort_keys=True)
    )

    (DATA_DIR / "pokemon.json").write_text(
        json.dumps(pokemon_out, indent=2, sort_keys=True)
    )
    (DATA_DIR / "moves.json").write_text(
        json.dumps(moves_out, indent=2, sort_keys=True)
    )
    (DATA_DIR / "types.json").write_text(
        json.dumps(types_out, indent=2, sort_keys=True)
    )
    (DATA_DIR / "evolution-chains.json").write_text(
        json.dumps(evolution_chains, indent=2, sort_keys=True)
    )

    for f in ["pokemon.json", "moves.json", "types.json", "evolution-chains.json",
              "shiny-gender-diff.json", "shiny-national.json", "abilities.json"]:
        path = DATA_DIR / f
        print(f"Wrote {path.relative_to(PROJECT_ROOT)} · {path.stat().st_size/1024/1024:.1f} MB", file=sys.stderr)

if __name__ == "__main__":
    main()
