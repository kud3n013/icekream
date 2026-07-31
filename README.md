# IceKream Bucket 🍨 by kud3n

[![Tests](https://github.com/kud3n013/icekream/actions/workflows/ci.yml/badge.svg)](https://github.com/kud3n013/icekream/actions/workflows/ci.yml) [![Excavator](https://github.com/kud3n013/icekream/actions/workflows/excavator.yml/badge.svg)](https://github.com/kud3n013/icekream/actions/workflows/excavator.yml)

Template bucket for [Scoop](https://scoop.sh), the Windows command-line installer.

## What apps are included?

| Application | Manifest | Auto-Update | Description |
|---|---|---|---|
| [UniKey](https://unikey.org/en) | `unikey` | ⚡ Yes | Vietnamese input method editor |
| [Zalo](https://zalo.me/en/product/zalo) | `zalo` | ⚡ Yes | Desktop messaging application |
| [Canva Desktop](https://www.canva.com) | `canva` | ⚡ Yes | Graphic design & presentation platform |
| [Attack Shark X6](https://www.attackshark.pro) | `attackshark-x6` | 🛠️ Manual | Mouse configuration software |
| [Macmillan Education Everywhere](https://www.macmillaneducationeverywhere.com) | `mee` | 🛠️ Manual | Digital teaching and learning platform |
| [Navio](https://www.macmillaneducationeverywhere.com) | `navio` | 🛠️ Manual | Interactive learning platform by Macmillan Education |
| [Sine](https://github.com/CosmoCreeper/Sine) | `sine` | ⚡ Yes | Theme & mod manager for Firefox-based browsers |
| [Docker Desktop](https://www.docker.com/products/docker-desktop/) | `docker-desktop` | ⚡ Yes | Build and share containerized applications (per-user) |
| [Docker Desktop (Nonportable)](https://www.docker.com/products/docker-desktop/) | `docker-desktop-np` | ⚡ Yes | Build and share containerized applications (all-users) |

## How do I install these manifests?

After manifests have been committed and pushed, run the following:

```pwsh
scoop bucket add kud3n013_icekream https://github.com/kud3n013/icekream
scoop install kud3n013_icekream/unikey
scoop install kud3n013_icekream/zalo
scoop install kud3n013_icekream/canva
scoop install kud3n013_icekream/attackshark-x6
scoop install kud3n013_icekream/mee
scoop install kud3n013_icekream/navio
scoop install kud3n013_icekream/sine
scoop install kud3n013_icekream/docker-desktop
scoop install kud3n013_icekream/docker-desktop-np
```

