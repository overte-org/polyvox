{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };
  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } (
      { self, ... }:
      {
        imports = [ inputs.treefmt-nix.flakeModule ];
        systems = [
          "x86_64-linux"
          "aarch64-linux"
          "aarch64-darwin"
        ];

        perSystem =
          { pkgs, ... }:
          {
            packages = rec {
              polyvox = pkgs.callPackage (
                { stdenv, cmake }:
                stdenv.mkDerivation {
                  pname = "polyvox";
                  version = "${self.dirtyShortRev}";
                  src = ./.;
                  cmakeFlags = [ "-DENABLE_EXAMPLES=OFF" ];
                  nativeBuildInputs = [ cmake ];
                }
              ) { };
              default = polyvox;
            };
            devShells.default = pkgs.mkShell {
              packages = [
                pkgs.cmake
                pkgs.doxygen
                pkgs.libGL
                pkgs.libGLU
                pkgs.glew
                pkgs.libx11
              ];

              buildInputs = [ (with pkgs.libsForQt5; env "qt-env-${qtbase.version}" [ ]) ];
            };
            treefmt = {
              projectRootFile = "README.md";
              programs = {
                clang-format = {
                  enable = true;
                };
              };
            };
          };
      }
    );
}
