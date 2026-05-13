{ stdenvNoCC }:

stdenvNoCC.mkDerivation {
  pname = "us-cz-programmer-xkb";
  version = "0.0.1";

  src = ../.;

  installPhase = ''
    runHook preInstall

    install -Dm0644 xkb/symbols/us-cz-programmer \
      "$out/share/X11/xkb/symbols/us-cz-programmer"

    runHook postInstall
  '';

  meta = {
    description = "US keyboard layout with Czech programmer AltGr layer";
    homepage = "https://github.com/cniry/keyboard-us-cz-programmer";
  };
}
