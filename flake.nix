{
  description = "Biosim4 Nix Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.default = 
      with import nixpkgs {
        system = "x86_64-linux";
      };
    stdenv.mkDerivation {
        name = "biosim4";
        src = self;
        installPhase = "mkdir -p $out/bin; install -t $out/bin biosim4";
      };
    apps = {
      default = {
        type = "app";
        program = "biosim4";
      };
    };

  };
}
