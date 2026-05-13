# Ubuntu / Linux Mint installation

Ubuntu and Linux Mint can use this layout too. The layout itself is a regular XKB symbols file, so it is not NixOS-specific.

## Install the symbols file

From the repository root:

```bash
sudo cp xkb/symbols/us-cz-programmer /usr/share/X11/xkb/symbols/us-cz-programmer
```

## X11 test

For an X11 session, test it with:

```bash
setxkbmap us-cz-programmer -option lv3:ralt_switch
```

Revert to the standard US layout with:

```bash
setxkbmap us
```

## GNOME on Ubuntu / Mint Wayland

GNOME on Wayland usually ignores `setxkbmap` for native Wayland apps. Set the input source through dconf instead:

```bash
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us-cz-programmer')]"
gsettings set org.gnome.desktop.input-sources xkb-options "['lv3:ralt_switch']"
```

Then log out and log back in.

Verify the setting with:

```bash
gsettings get org.gnome.desktop.input-sources sources
gsettings get org.gnome.desktop.input-sources xkb-options
```

Expected values include:

```text
[('xkb', 'us-cz-programmer')]
['lv3:ralt_switch']
```

## Test keys

```text
AltGr + c = č
AltGr + 4 = č
AltGr + 5 = ř
AltGr + ; = ů
AltGr + \\ = ň
AltGr + Shift + e = €
AltGr + Shift + ` = °
```

## Notes for graphical keyboard settings

Without registering the layout in XKB rules, the layout may not appear nicely in the graphical keyboard settings UI. It can still be activated through `setxkbmap` on X11 or `gsettings` on GNOME/Wayland.

A full Ubuntu/Mint package could additionally install XKB rules metadata so the layout appears in the desktop environment's keyboard picker.

## Uninstall

Remove the symbols file:

```bash
sudo rm /usr/share/X11/xkb/symbols/us-cz-programmer
```

Then switch back to another layout, for example:

```bash
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us')]"
gsettings set org.gnome.desktop.input-sources xkb-options "[]"
```
