# Headless Anki

Minimal headless Anki Docker images. No plugins, no authentication - just Anki.

## Variants

| Variant | VNC | Window Manager | Use Case |
|---------|-----|----------------|----------|
| `pypi/` | Qt VNC (basic) | No | Headless automation |
| `pypi-x11/` | x11vnc + openbox | Yes | Debugging with full GUI |

## Quick Start

```bash
cd pypi      # or pypi-x11
./run.sh
```

Connect VNC to `localhost:5900`.

## Building

```bash
cd pypi
docker build -t headless-anki:latest .

# Specific version (any from 2.1.24 to latest)
docker build --build-arg ANKI_VERSION=25.9.2 -t headless-anki:latest .
```

## Credits

Inspired by [ThisIsntTheWay/headless-anki](https://github.com/ThisIsntTheWay/headless-anki).
