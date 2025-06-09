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
        devShell = pkgs.mkShell {
          buildInputs = [
            python-with-opencv
            pkgs.pkg-config
            pkgs.stdenv.cc.cc.lib
            pkgs.gnuplot
            pkgs.cmake
            pkgs.cimg
          ];

          shellHook = ''
            export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH
            echo "Python environment ready with OpenCV $(python -c 'import cv2; print(cv2.__version__)')"
          '';
        };
      }
    );
}
