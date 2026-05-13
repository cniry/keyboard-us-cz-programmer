{
  description = "US keyboard layout with Czech programmer AltGr layer";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          default = pkgs.callPackage ./package {};
          us-cz-programmer-xkb = pkgs.callPackage ./package {};
        }
      );

      nixosModules.default = ./nixos/us-cz-programmer.nix;
      nixosModules.us-cz-programmer = ./nixos/us-cz-programmer.nix;
    };
}
