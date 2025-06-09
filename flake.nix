{
  description = "BioSim Development Shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        python-with-opencv = pkgs.python3.withPackages (ps: [
          ps.opencv4
        ]);
      in {
        stdenv.mkDerivation = {
          name = "biosim4";
          src = self;
          buildPhase = "make";
          installPhase = ''
            mkdir -p $out/bin
            cp src/biosim4 $out/bin/biosim4
          '';
        };

        devShell = pkgs.mkShell {
          buildInputs = [
            python-with-opencv
            pkgs.pkg-config
            pkgs.stdenv.cc.cc.lib
            pkgs.gnuplot
            pkgs.cmake
            pkgs.cimg
          ];
        };

        apps = {
          biosim4 = {
            type = "app";
            program = "${self}/bin/biosim4";
          };
        };
      }
    );
}
