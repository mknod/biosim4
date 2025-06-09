{
  description = "Minimal Biosim4 Nix Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    defaultPackage.x86_64-linux = 
      with import nixpkgs {
        system = "x86_64-linux";
      };
      stdenv.mkDerivation {
        name = "biosim4";
        src = self;
        installPhase = "mkdir -p $out/bin; install -t $out/bin biosim4";
      };
  };
}