# keyboard-us-cz-programmer

US keyboard layout with a Czech programmer AltGr layer.

Repository:

```text
github.com/cniry/keyboard-us-cz-programmer
```

The XKB layout name is:

```text
us-cz-programmer
```

The Nix package name is:

```text
us-cz-programmer-xkb
```

Version: `0.0.1`

## Goals

- Keep the standard US layout for programming.
- Add Czech characters through AltGr.
- Preserve part of Czech keyboard muscle memory on the number row.
- Work on NixOS, Ubuntu, Linux Mint, X11, and GNOME/Wayland with the right desktop configuration.

## Layout

See [layout.md](./layout.md).

Important examples:

```text
AltGr + c = č
AltGr + 4 = č
AltGr + 5 = ř
AltGr + ; = ů
AltGr + \\ = ň
AltGr + Shift + e = €
AltGr + Shift + ` = °
```

## Installation guides

- [NixOS installation](./docs/README-NixOS.md)
- [Ubuntu / Linux Mint installation](./docs/README-Ubuntu-Mint.md)

## Quick X11 test

The included test script is only for X11 sessions, not native Wayland apps:

```bash
./scripts/test-local.sh
```

Revert with:

```bash
setxkbmap us
```
