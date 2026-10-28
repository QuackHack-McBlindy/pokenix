<div align="center">

<img src="images/logo.png" alt="Logo" width="240">
<br>


![License](https://img.shields.io/badge/license-MIT-black?style=flat-square&logo=opensourceinitiative&logoColor=white)
![Updated for](https://img.shields.io/badge/Updated%20for-Pok%C3%A9mon%20Sword%2FShield%20(Crown%20Tundra%20DLC)-blue)
[![Sponsors](https://img.shields.io/github/sponsors/QuackHack-McBlindy?logo=githubsponsors&label=Sponsor&style=flat&labelColor=ff1493&logoColor=fff&color=rgba(234,74,170,0.5) "")](https://github.com/sponsors/QuackHack-McBlindy)
[![Buy Me a Coffee](https://img.shields.io/badge/Buy%20Me%20a%20Coffee-Sponsor?style=flat&logo=buymeacoffee&logoColor=fff&labelColor=ff1493&color=ff1493)](https://buymeacoffee.com/quackhackmcblindy)


[![Built with Nix](https://img.shields.io/badge/Built%20with-Nix-5277C3?style=flat&labelColor=5277C3&color=555&logo=nixos&logoColor=fff)](https://nixos.org)

</div>


# **PokéNix - Pokémon Collection Builder**

**You** simply write your Pokémons using the options.<br>
**PokéNix** builds and updates your collection website.<br>
**Version controlled, and always online.**<br>

<br>

- [x] **Trainer** - Who's training these Pokémon?
- [x] **Breedable Apriballs Pokémon** - Optimized for breeding/trading. Click your mons and CTRL + C them as a list.
- [x] **Event Pokémon** - A collection worth Cherish*ishing*.
- [x] **True** *(♀️♂️)* **Shiny Living Dex** - Watch your shiny progress grow in %. Toggle between caught/missing.
- [x] **Specials** - Rare marks, awesome EV stats or simply shared memories, any Pokémon belongs! Document anything you want. 
- [x] **Search** - Quickly search and find what you are looking for.

<br>
<a href="https://quackhack-mcblindy.github.io/pokenix/">PokéNix Live Example</a>
<br>

## **Prerequisites**

- A GitHub account *(free)*.

<br>

## **Installation**


<details><summary><strong>
Using GitHub Pages: No terminal, Nix or local install required.
</strong></summary>

1. Create a GitHub account, login and click "Fork" on this repository.
2. On the forked repo go to: Settings > Pages > Source: GitHub Actions.
3. On your forked repo click on the pencil icon on the file `my-pokemon.nix`.
4. Write your trainer name and your Pokémon (helpful comments in file), save the file when done.
5. Wait 3 minutes. First time may take a  few minutes longer.
6. Visit https://<github-username>.github.io/pokenix/

<br>

If PokéNix's version update or new Pokémon are available click "Sync fork" on your forked repository.<br>
It won't affect the `my-pokemon.nix` file.<br>

<br>

</details>

<br>


<details><summary><strong>
❄️ Using flakes (NixOS)
</strong></summary>


#### **1: Add PokéNix as input in your flake.nix**

```nix
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    pokenix.url = "github:quackhack-mcblindy/pokenix";
  };
```

<br>

#### **2: Import the module into your configuration**


```nix
  imports = [
    pokenix.nixosModules.pokenix
  ];
```

<br>

#### **3: Rebuild your system**

**Done!**

<br>


## **Templates**


Battle tested and ready to use templates can be found in <a href="templates/">templates/</a>.<br>


<br>

</details>

<br>

<details><summary><strong>
macOS / Linux / WSL, with Nix installed
</strong></summary>


```
git clone https://github.com/QuackHack-McBlindy/pokenix
cd pokenix
$EDITOR my-pokemon.nix
nix build .#default
xdg-open result/index.html  # or `open` on macOS
```

<br>

</details>

<br>

## **Notes**


♥️ **Special thanks to** <a href="https://github.com/msikma/pokesprite">msikma/pokesprite</a> for making this project possible.

<br>


## **Disclaimer**


Pokémon and all related names, characters, designs, and trademarks belong to their respective owners, including Nintendo, Creatures Inc., and GAME FREAK inc.<br>
PokéNix is an unofficial fan project and is not affiliated with or endorsed by them.<br>


<br>


## **License**

This project is licensed under the terms of the MIT license.<br>
See the `LICENSE` file in the repository for full details.<br>

Contributions are welcomed.
