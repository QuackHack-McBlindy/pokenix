<div align="center">

<img src="images/logo.png" alt="Logo" width="240">
<br>

[![Sponsors](https://img.shields.io/github/sponsors/QuackHack-McBlindy?logo=githubsponsors&label=Sponsor&style=flat&labelColor=ff1493&logoColor=fff&color=rgba(234,74,170,0.5) "")](https://github.com/sponsors/QuackHack-McBlindy) [![Buy Me a Coffee](https://img.shields.io/badge/Buy%20Me%20a%20Coffee-Sponsor?style=flat&logo=buymeacoffee&logoColor=fff&labelColor=ff1493&color=ff1493)](https://buymeacoffee.com/quackhackmcblindy)
![License](https://img.shields.io/badge/license-MIT-black?style=flat-square&logo=opensourceinitiative&logoColor=white)


[![Built with Nix](https://img.shields.io/badge/Built%20with-Nix-5277C3?style=flat&labelColor=5277C3&color=555&logo=nixos&logoColor=fff)](https://nixos.org)

</div>


# **PokéNix - Pokémon Collection Website Using NixOS**

**You** define your mons using the NixOS options.<br>
**PokéNix** builds your collection website.<br>


<br>


## **Installation**

<details><summary><strong>
❄️ Using flakes
</strong></summary>


#### **1: Add PokéNix as inputs in your flake.nix**

```nix
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    pokenix.url = "github:quackhack-mcblindy/pokenix";
  };
```


#### **2: Import the module into your configuration**


```nix
  imports = [
    pokenix.nixosModules.pokenix
  ];
```

</details>
<br>

## **License**

This project is licensed under the terms of the MIT license.<br>
See the `LICENSE` file in the repository for full details.<br>

Contributions are welcomed.


