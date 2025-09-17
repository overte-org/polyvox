{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } (
      { inputs, ... }:
      {
        systems = [
          "x86_64-linux"
          "aarch64-linux"
          "aarch64-darwin"
        ];

        perSystem =
          {
            pkgs,
            lib,
            self',
            inputs',
            ...
          }:
          {
            devShells.default = pkgs.mkShell {
              packages = [
                pkgs.cmake
              ];

              buildInputs = [ (with pkgs.libsForQt5; env "qt-env-${qtbase.version}" [ ]) ];
            };
          };
      }
    );
}
