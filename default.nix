{ sources ? import ./nix/sources.nix { }
, pkgs ? import sources.nixpkgs { overlays = [ (import ./nix/wasmtime.nix) ]; }
}:
pkgs.wasmtime
