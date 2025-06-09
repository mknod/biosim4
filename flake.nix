{
  description = "Minimal Biosim4 Nix Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: 

     let

      # to work with older version of flakes
      lastModifiedDate = self.lastModifiedDate or self.lastModified or "19700101";

      # Generate a user-friendly version number.
      version = builtins.substring 0 8 lastModifiedDate;

      # System types to support.
      supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];

      # Helper function to generate an attrset '{ x86_64-linux = f "x86_64-linux"; ... }'.
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      # Nixpkgs instantiated for supported system types.
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; overlays = [ self.overlay ]; });
    in

    {

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