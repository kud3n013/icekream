# IceKream Bucket by kud3n

[![Tests](https://github.com/kud3n/icekream-bucket/actions/workflows/ci.yml/badge.svg)](https://github.com/kud3n/icekream-bucket/actions/workflows/ci.yml) [![Excavator](https://github.com/kud3n/icekream-bucket/actions/workflows/excavator.yml/badge.svg)](https://github.com/kud3n/icekream-bucket/actions/workflows/excavator.yml)

Template bucket for [Scoop](https://scoop.sh), the Windows command-line installer.

## What apps are included?

- [Unikey](https://unikey.org/en)
- [Zalo](https://zalo.me/en/product/zalo)

## How do I install these manifests?

After manifests have been committed and pushed, run the following:

```pwsh
scoop bucket add icekream https://github.com/kud3n/icekream-bucket
scoop install icekream/unikey
scoop install icekream/zalo
```

