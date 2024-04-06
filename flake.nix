{
  description = "A debug header library for C++";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        packages.cp-tools = pkgs.stdenv.mkDerivation {
          name = "cp-tools";
          version = "1.0";
          src = self;
          installPhase = ''
            mkdir -p $out/include/cp-tools
            cp src/* $out/include/cp-tools/
          '';
          meta = {
            description =
              "A general purpose debug header file for C++ projects";
            license = pkgs.lib.licenses.mit;
          };
        };
        defaultPackage = self.packages.${system}.cp-tools;
      });
}
