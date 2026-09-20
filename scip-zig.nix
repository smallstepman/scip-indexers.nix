# Broken with the Zig toolchain currently supplied by nixpkgs.
#
# The pinned upstream source uses the pre-Zig-0.11 build API:
# `std.build.Builder`. nixpkgs currently provides Zig 0.16.0, where that API
# was replaced by `std.Build`; the build fails before compiling the indexer.
#
# Fix options:
# - pin or override `pkgs.zig` to a compiler compatible with this source;
# - update the upstream build.zig from `std.build.Builder` and its legacy
#   methods to the modern `std.Build` API, preferably by consuming an upstream
#   revision that already made that migration; or
# - carry a Nix source patch for that migration, updating the source hash and
#   validating the generated executable.
# Re-run `nix build .#scip-zig --no-link` after changing the compiler or source.

{ pkgs }:
pkgs.stdenv.mkDerivation {
  pname = "scip-zig";
  version = "unstable-2023-03-03";
  src = pkgs.fetchFromGitHub {
    owner = "zigtools";
    repo = "scip-zig";
    rev = "main";
    hash = "sha256-NQgmHfvuQbHNuJNLqgY4BRmbpULIP/YUahc9EVCovDs=";
  };
  nativeBuildInputs = [ pkgs.zig ];
  buildPhase = ''
    zig build -Drelease-safe
  '';
  installPhase = ''
    install -Dm755 zig-out/bin/scip-zig $out/bin/scip-zig
  '';
  meta = {
    description = "Experimental SCIP indexer for Zig";
    homepage = "https://github.com/zigtools/scip-zig";
    license = pkgs.lib.licenses.mit;
    mainProgram = "scip-zig";
  };
}
