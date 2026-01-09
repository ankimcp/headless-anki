# Headless Anki (PyPI-based)

Installs Anki via pip from PyPI. Supports latest versions (25.07+).

## Usage

```bash
./run.sh
```

## Build Args

- `ANKI_VERSION` - Version to install (default: 25.9.2)

```bash
docker build --build-arg ANKI_VERSION=25.9.2 -t headless-anki:pypi .
```

## Notes

- Larger image than tarball-based due to pip dependencies
- Experimental - Qt dependencies may need tweaking
