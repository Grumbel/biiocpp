{
  description = "Binary file I/O";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";

    tinycmmc.url = "github:grumbel/tinycmmc";
    tinycmmc.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, tinycmmc }:
    tinycmmc.lib.eachSystemWithPkgs (pkgs:
      {
        packages = rec {
          default = biiocpp;

          biiocpp = pkgs.stdenv.mkDerivation {
            pname = "biiocpp";
            version = "0.0.0";

            src = nixpkgs.lib.cleanSource ./.;

            nativeBuildInputs = [
              pkgs.buildPackages.cmake
            ];

            buildInputs = [
              tinycmmc.packages.${pkgs.system}.default

              pkgs.gtest
            ];
           };
        };
      }
    );
}
