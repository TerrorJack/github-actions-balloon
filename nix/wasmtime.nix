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
        version = "0.22.1";

        src = fetchFromGitHub {
          owner = "bytecodealliance";
          repo = pname;
          rev = "v${version}";
          sha256 = "sha256-aNKrhIpTtHTjitm/cBTgP3PHtdIXS/6xvevoNE0G16Y=";
          fetchSubmodules = true;
        };

        cargoHash =
          "sha512-KkGw8bkU4Nm6aeaJAfcVB14xn2csw58Iw/UM+GYp7OeAcI/aY4sSH8Elm0R4rsxb2WTcgu1Nl/EK0u5I+/6/4w==";

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
