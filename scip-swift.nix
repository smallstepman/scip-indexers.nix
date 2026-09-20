# Broken with the Swift toolchain currently supplied by nixpkgs.
#
# The upstream Package.swift declares `// swift-tools-version: 6.2`, while
# nixpkgs currently provides SwiftPM 5.10.1 on Darwin. SwiftPM rejects the
# package before dependency resolution or compilation, so this derivation
# cannot currently be built as written.
#
# Fix options:
# - update nixpkgs (or override `swiftPackages.swift` and `swiftPackages.swiftpm`)
#   to a toolchain that supports Swift tools version 6.2;
# - package a compatible Swift 6.2 toolchain and use its SwiftPM here; or
# - maintain a source patch lowering the tools-version only if all upstream
#   dependencies and language features remain compatible, then update the
#   source hash and verify the resulting binary.
# Re-run `nix build .#scip-swift --no-link` after the toolchain/source change.

{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "scip-swift";
  version = "unstable-2026-09-20";
  src = pkgs.fetchFromGitHub {
    owner = "jarvis-intelligence";
    repo = "scip-swift";
    rev = "main";
    hash = "sha256-GPYsuBFFJQaZRcsvVUBojzTExq27p0CLVxrMR/OkWOc=";
  };
  nativeBuildInputs = [ pkgs.swiftPackages.swift pkgs.swiftPackages.swiftpm ];
  buildPhase = ''
    swift build -c release
  '';
  installPhase = ''
    install -Dm755 .build/release/scip-swift $out/bin/scip-swift
  '';
  meta = {
    description = "SCIP indexer for Swift using IndexStoreDB";
    homepage = "https://github.com/jarvis-intelligence/scip-swift";
    license = pkgs.lib.licenses.asl20;
    mainProgram = "scip-swift";
    platforms = pkgs.lib.platforms.darwin;
  };
}
