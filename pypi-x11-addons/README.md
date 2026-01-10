# Headless Anki (PyPI + X11 + Addons)

X11 variant with addon support. Addons are downloaded from AnkiWeb during build.

## Usage

```bash
# Without addons
./run.sh

# With addons (build with addon IDs)
docker build --build-arg ADDON_IDS="2055492159 1463041493" -t headless-anki:addons .
docker compose up
```

## Build Args

| Arg | Default | Description |
|-----|---------|-------------|
| `ANKI_VERSION` | 25.9.2 | Anki version |
| `ADDON_IDS` | "" | Space-separated addon IDs from AnkiWeb |

## Finding Addon IDs

Addon IDs are in the AnkiWeb URL:
```
https://ankiweb.net/shared/info/2055492159
                              ^^^^^^^^^^
                              This is the ID
```
