{
  description = "Biosim4 Nix Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    packages = {
      x86_64-linux = 
        with import nixpkgs {
          system = "x86_64-linux";
        };
        stdenv.mkDerivation {
          name = "biosim4";
          src = self;
          installPhase = "mkdir -p $out/bin; install -t $out/bin biosim4";
        };
    };

    apps = {
      x86_64-linux = {
        type = "app";
        program = "${self.packages.x86_64-linux.default}/bin/biosim4";
      };
    };
  };
}
