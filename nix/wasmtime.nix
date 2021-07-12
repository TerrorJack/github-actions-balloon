self: _: {
  wasmtime = self.callPackage
    ({ rustPlatform
     , fetchFromGitHub
     , lib
     , python
     , cmake
     , llvmPackages
     , clang
     , stdenv
     , darwin
     }:

      rustPlatform.buildRustPackage rec {
        pname = "wasmtime";
        version = "0.23.0";

        src = fetchFromGitHub {
          owner = "bytecodealliance";
          repo = pname;
          rev = "v${version}";
          sha256 = "sha256-5/zq8a7w0dSd9KHbXa9+5/qrZ9GQj3ryUUISpC3RyPs=";
          fetchSubmodules = true;
        };

        cargoHash =
          "sha512-iojZ4H37I+T0LmU2LcEn4euA+H82VKxP5IcEwiwyFokste2a96o5b8IZdloQuwNmWwOpvcYV+zjCWK0qPKmhCQ==";

        nativeBuildInputs = [ python cmake clang ];
        buildInputs = [ llvmPackages.libclang ] ++ lib.optionals stdenv.isDarwin
          [ darwin.apple_sdk.frameworks.Security ];
        LIBCLANG_PATH = "${llvmPackages.libclang.lib}/lib";

        doCheck = false;

        meta = with lib; {
          description =
            "Standalone JIT-style runtime for WebAssembly, using Cranelift";
          homepage = "https://github.com/bytecodealliance/wasmtime";
          license = licenses.asl20;
          maintainers = [ maintainers.matthewbauer ];
          platforms = platforms.unix;
        };
      })
    { };
}
