{
  description = "A very basic flake";

  inputs = { nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable"; };

  outputs = { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      stdenv = pkgs.stdenv;
    in {
      kitty_theme = stdenv.mkDerivation {
        name = "hello";
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "kitty";
          rev = "1f99e6682d84fe4d8e3177d3add8d0591607a2ac";
          sha256 = "1sfjwvn6xwc882mzv9nhb8wsw3q4kapypq7gh1dkq3jqcjc717b3";
        };
        buildCommand = ''
          # ls $src > log
          # mv log $out
          mkdir $out

          cp -r $src/themes $out

          # install $src/themes/ $out
        '';
      };

      packages.x86_64-linux.default = self.kitty_theme;

    };
}
