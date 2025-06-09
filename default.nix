{ pkgs ? import <nixpkgs> {} }:

let
  pythonWithOpencv = pkgs.python3.withPackages (ps: [
    ps.opencv4
  ]);
in
pkgs.stdenv.mkDerivation {
  name = "biosim4";

  src = ./.;

  

  buildInputs = [
    pythonWithOpencv
    pkgs.pkg-config
    pkgs.stdenv.cc.cc.lib
    pkgs.gnuplot
    pkgs.cmake
    pkgs.cimg
    pkgs.gnumake
    pkgs.zlib
  ];

  shellHook = ''
    export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH
    echo "Python environment ready with OpenCV $(python -c 'import cv2; print(cv2.__version__)')"
  '';

installPhase = ''
  mkdir -p $out/bin
  cp src/biosim4 $out/bin/biosim4
'';
}
