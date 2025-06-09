{
  description = "Minimal Biosim4 Nix Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    packages = {
      default = nixpkgs.ffmpeg;
    };


    defaultPackage.x86_64-linux = 
      with import nixpkgs {
        system = "x86_64-linux";
      };

      stdenv.mkDerivation {
        name = "biosim4";
        src = self;
        buildInputs = [
          python313Packages.opencv4
          pkg-config
          stdenv.cc.cc.lib
          gnuplot
          cmake
          cimg
          gnumake
          zlib
          
        ];
        installPhase = ''
            mkdir -p $out/bin
            cp src/biosim4 $out/bin/biosim4
          '';
        
      };
   
  };

}