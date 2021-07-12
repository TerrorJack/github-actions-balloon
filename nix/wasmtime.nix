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
        version = "0.25.0";

        src = fetchFromGitHub {
          owner = "bytecodealliance";
          repo = pname;
          rev = "v${version}";
          sha256 = "sha256-2qK/IraNoLM3CZbj/Sh+5Cc5bP3JOIHx8xaUp2AuecU=";
          fetchSubmodules = true;
        };

        cargoHash =
          "sha512-M4uQRtVMvOZMbK0dWZKN0SDWYX/YcK7R2+xgDVLXs+btQR4EWboXvWqzZMJEQl3LShokrpaVm/xwOC2cwkAi0Q==";

        nativeBuildInputs = [ python cmake clang ];
        buildInputs = [ llvmPackages.libclang ] ++ lib.optionals stdenv.isDarwin
          [ darwin.apple_sdk.frameworks.Security ];
        LIBCLANG_PATH = "${llvmPackages.libclang.lib}/lib";

        doCheck = true;

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
