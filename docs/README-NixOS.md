# NixOS installation

This repository provides both a Nix package and a NixOS module for the `us-cz-programmer` XKB layout.

## Usage without flakes

Clone or copy this repository to:

```text
/etc/nixos/keyboard/us-cz-programmer
```

Example:

```bash
sudo mkdir -p /etc/nixos/keyboard
cd /etc/nixos/keyboard
sudo git clone https://github.com/cniry/keyboard-us-cz-programmer.git us-cz-programmer
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

Then log out and log back in.

## Usage with flakes

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

Update the flake input when you want a newer version:

```bash
nix flake lock --update-input keyboard-us-cz-programmer
sudo nixos-rebuild switch --flake .
```

## GNOME on Wayland

GNOME on Wayland keeps its own user input source list in dconf. If GNOME still shows the old keyboards after a reboot, set the input source through Home Manager.

Add this to your Home Manager user config:

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

## Verification

Check GNOME input sources:

```bash
gsettings get org.gnome.desktop.input-sources sources
gsettings get org.gnome.desktop.input-sources xkb-options
```

Expected values include:

```text
[('xkb', 'us-cz-programmer')]
['lv3:ralt_switch']
```

Then test:

```text
AltGr + c = č
AltGr + 4 = č
AltGr + 5 = ř
AltGr + ; = ů
AltGr + \\ = ň
AltGr + Shift + e = €
AltGr + Shift + ` = °
```

## Quick X11-only test

The included test script is only for X11 sessions, not native Wayland apps:

```bash
./scripts/test-local.sh
```

Revert with:

```bash
setxkbmap us
```
