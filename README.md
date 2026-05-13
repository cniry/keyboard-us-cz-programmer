# keyboard-us-cz-programmer

US keyboard layout with Czech programmer AltGr layer.

Repository intended location:

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
- Work well on NixOS, including GNOME on Wayland when GNOME input sources are set through dconf.

## Layout

See [layout.md](./layout.md).

Important examples:

```text
AltGr + c = č
AltGr + 4 = č
AltGr + 5 = ř
AltGr + ; = ů
AltGr + \ = ň
AltGr + Shift + e = €
AltGr + Shift + ` = °
```

## NixOS usage without flakes

Clone or copy this repository to:

```text
/etc/nixos/keyboard/us-cz-programmer
```

Then import the module in `/etc/nixos/configuration.nix`:

```nix
{
  imports = [
    ./hardware-configuration.nix
    ./keyboard/us-cz-programmer/nixos/us-cz-programmer.nix
  ];

  services.xserver.xkb = {
    layout = "us-cz-programmer";
    variant = "";
    options = "lv3:ralt_switch";
  };
}
```

Run:

```bash
sudo nixos-rebuild switch
```

Log out and log back in.

## NixOS usage with flakes

In your system flake:

```nix
inputs.keyboard-us-cz-programmer.url = "github:cniry/keyboard-us-cz-programmer";
```

Then import the module:

```nix
{
  imports = [
    inputs.keyboard-us-cz-programmer.nixosModules.default
  ];

  services.xserver.xkb = {
    layout = "us-cz-programmer";
    variant = "";
    options = "lv3:ralt_switch";
  };
}
```

## GNOME on Wayland

GNOME on Wayland keeps its own user input source list in dconf. If you use Home Manager, add this to your user config:

```nix
{ pkgs, lib, ... }:

{
  dconf.enable = true;

  dconf.settings = {
    "org/gnome/desktop/input-sources" = {
      sources = [
        (lib.hm.gvariant.mkTuple [ "xkb" "us-cz-programmer" ])
      ];

      xkb-options = [
        "lv3:ralt_switch"
      ];
    };
  };
}
```

Then rebuild and log out/log back in.

## Quick X11 test

The included test script is only for X11 sessions, not native Wayland apps:

```bash
./scripts/test-local.sh
```

Revert with:

```bash
setxkbmap us
```
