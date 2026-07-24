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

## How do I install these manifests?

After manifests have been committed and pushed, run the following:

```pwsh
scoop bucket add kud3n013_icekream https://github.com/kud3n013/icekream
scoop install kud3n013_icekream/unikey
scoop install kud3n013_icekream/zalo
scoop install kud3n013_icekream/canva
scoop install kud3n013_icekream/attackshark-x6
scoop install kud3n013_icekream/mee
```

