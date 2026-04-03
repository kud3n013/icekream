# IceKream Bucket 🍨 by kud3n

[![Tests](https://github.com/kud3n013/icekream/actions/workflows/ci.yml/badge.svg)](https://github.com/kud3n013/icekream/actions/workflows/ci.yml) [![Excavator](https://github.com/kud3n013/icekream/actions/workflows/excavator.yml/badge.svg)](https://github.com/kud3n013/icekream/actions/workflows/excavator.yml)

Template bucket for [Scoop](https://scoop.sh), the Windows command-line installer.

## What apps are included?

- [Unikey](https://unikey.org/en)
- [Zalo](https://zalo.me/en/product/zalo)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [Wacom Driver](https://www.wacom.com/en-us/support/product-support/drivers)

## How do I install these manifests?

After manifests have been committed and pushed, run the following:

```pwsh
scoop bucket add kud3n013_icekream https://github.com/kud3n/icekream-bucket
scoop install kud3n013_icekream/unikey
scoop install kud3n013_icekream/zalo
scoop install kud3n013_icekream/docker-desktop
scoop install kud3n013_icekream/wacom-driver
```

