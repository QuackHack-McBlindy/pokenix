# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Web editor: — click `Edit` on any page to edit breedables, shiny, events, specials, and the trainer profile directly from the browser. Copy and paste into users GitHub fork using buttons. PokéNix now only requires a browser and zero Nix knowledge.
- Generation 9 now supported. 
- Edit persistence: — changes are saved to `localStorage` as a diff against the Nix data, so they survive page reloads and navigation until you export or clear site data.
- New option: `pokenix.trainer.shinyDexType`, user now selects their shiny living dex type (`national` or `gender-diff`).
- Extended option: `pokenix.pokedex` with ribbons, marks, abilities, moves, items.


### Changed

- Moved `trainer.html` to `index.html`, breedables now at `breedables.html`.
- Modularized `build.nix` into `lib/*.nix`.
- Shiny roster loads from `data/pokedex/shiny-<type>.json` instead of `./shiny/*.nix`.
- Shiny entries missing from `pokenix.shiny` are filled in from a matching `pokenix.specials` entry.

### Fixed

- CI now fetch options and builds the documentation.

### Removed

- Removed `data/pokedex/base-stats.json` — derived from `pokedex/pokemon.json`.
- Removed `data/pokedex/egg-moves.json` — merged into `moves.json` (`.egg` field).
- Removed `scripts/fetch_egg_moves.py` — data already produced by `fetch_pokemon.py`.
- Removed all `./shiny/*.nix` files.


## [1.0.4] - 2026-11-03

### Added

- New options: `pokenix.pokedex` and `pokenix.moves` - filled with readable data.
- New options: `pokenix.trainer.githubUsername` and `pokenix.trainer.githubURepo`.
- New option: `pokenix.shiny.<name>.name` used for naming a pokemon.
- Added Poké cries to the generated website.
- Added types on all pages and other minor visual improvements. 

### Changed

- Changed the ogImage to display aprimons, shiny living derx, event mons and special mons each on it's own row. 
- Data fetching scripts improved to gather more data.

### Fixed

- Fixed the ogImage to absolute URL resolved by the new pokenix.trainer.github options.
- Fixed missing `pokenix.shiny.<name>.species`, making automatic identification now possible.

### Removed

## [1.0.3] - 2026-11-02

### Added

### Changed

- Changed the default trainer picture.
- Updated the `example.nix` file.
- Updated the installation instructions in the `README.md`.

### Fixed

### Removed

## [1.0.2] - 2026-10-31

### Added

- Added Nix flake check.

### Changed

- Improved `example.nix`.

### Fixed

### Removed

## [1.0.1] - 2026-10-29

### Added

- [x] **Trainer** - Who's training these Pokémon?
- [x] **Breedable Apriballs Pokémon** - Optimized for breeding/trading. Click #Dex link to serebii. Click your chosen balls and CTRL + C them as a list. Click any Pokémon to view all their egg moves. Hover for move info.  
- [x] **Event Pokémon** - A collection worth Cherish*ishing*.
- [x] **True** *(♀️♂️)* **Shiny Living Dex** - Watch your shiny progress grow in %. Easy toggle between caught/missing.
- [x] **Specials** - Rare marks, ribbons or simply shared memories, any Pokémon belongs! Document anything! Enter IV/EV, nature and your Pokémon stats willl be auto-generated and displayed. 
- [x] **Search** - Quickly live search and find what you are looking for.
- **GitHub Pages** - If used with GitHub Pages: ❌ terminal, ❌ Nix, ❌ local download required. ✅ Simple!


### Changed

### Fixed

### Removed

## [0.1.0]

