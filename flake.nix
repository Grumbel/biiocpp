{
  description = "Binary file I/O";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
    flake-utils.url = "github:numtide/flake-utils";

    tinycmmc.url = "github:grumbel/tinycmmc";
    tinycmmc.inputs.nixpkgs.follows = "nixpkgs";
    tinycmmc.inputs.flake-utils.follows = "flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, tinycmmc }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in rec {
        packages = flake-utils.lib.flattenTree {
          biiocpp = pkgs.stdenv.mkDerivation {
            pname = "biiocpp";
            version = "0.0.0";
            src = nixpkgs.lib.cleanSource ./.;
            nativeBuildInputs = [
              pkgs.cmake
            ];
            buildInputs = [
              tinycmmc.defaultPackage.${system}

              pkgs.gtest
            ];
           };
        };
        defaultPackage = packages.biiocpp;
      });
}
