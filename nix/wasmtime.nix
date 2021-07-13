self: _: {
  wasmtime = self.callPackage
    ({ fetchzip, lib, stdenv }:
      stdenv.mkDerivation rec {
        name = "wasmtime";
        version = "0.28.0";
        src = fetchzip {
          x86_64-linux = {
            url =
              "https://github.com/bytecodealliance/wasmtime/releases/download/v${version}/wasmtime-v${version}-x86_64-linux.tar.xz";
            hash =
              "sha512-2431CxxPPrB7x5VbrpG2daRMcqubMQxmLg9yqiiTrIRYFecS/KbGbBDam0vR1+yOFYNSooaU8sKn1+FjkukeuQ==";
          };
          aarch64-linux = {
            url =
              "https://github.com/bytecodealliance/wasmtime/releases/download/v${version}/wasmtime-v${version}-aarch64-linux.tar.xz";
            hash =
              "sha512-zebIwLyq9gg6tct9sGtbu7Yil//o9q8sXHr48HARdT00bOo8D1kF0QlM8HURsWO52fq26X7n9ZbC29fD6jqO8w==";
          };
          x86_64-darwin = {
            url =
              "https://github.com/bytecodealliance/wasmtime/releases/download/v${version}/wasmtime-v${version}-x86_64-macos.tar.xz";
            hash =
              "sha512-NPpGMPsDBqL7EGnNHRg+ZLA3ZEc3UKgPLrSONPqUhM3jG5aPR1h1Eqdt3eb2ud83onLE8pDgHR3r2QVbiHNDgQ==";
          };
        }.${stdenv.hostPlatform.system};
        phases =
          [ "unpackPhase" "buildPhase" "installPhase" "installCheckPhase" ];
        buildPhase = ''
          patchelf \
            --set-interpreter $(cat $NIX_CC/nix-support/dynamic-linker) \
            --set-rpath ${lib.makeLibraryPath [ stdenv.cc.libc ]} \
            wasmtime
        '';
        installPhase = ''
          mkdir -p $out/bin
          mv wasmtime $out/bin
        '';
        doInstallCheck = true;
        installCheckPhase = ''
          $out/bin/wasmtime --version
        '';
      })
    { };
}
