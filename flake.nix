{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } (
      { self, ... }:
      {
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
                {
                  stdenv,
                  cmake,
                  qt6,
                }:
                stdenv.mkDerivation {
                  pname = "polyvox";
                  version = "${self.shortRev or self.dirtyShortRev or "dirty"}";
                  src = ./.;
                  cmakeFlags = [ "-DENABLE_EXAMPLES=OFF" ];
                  nativeBuildInputs = [
                    qt6.wrapQtAppsHook
                    cmake
                  ];
                  buildInputs = [
                    qt6.qtbase
                  ];
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

              buildInputs = [ (with pkgs.qt6; env "qt-env-${qtbase.version}" [ ]) ];
            };
          };
      }
    );
}
