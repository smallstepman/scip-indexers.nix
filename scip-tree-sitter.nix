{ pkgs }:
pkgs.rustPlatform.buildRustPackage {
  pname = "scip-tree-sitter";
  version = "unstable-2026-09-20";
  src = pkgs.fetchFromGitHub {
    owner = "jelmer";
    repo = "scip-tools";
    rev = "a4d7b78acbd26b9407bbab59b4276e07896c5c1f";
    hash = "sha256-/GwCEerVtbHsTIlLNRw44JTDGxhbpl87fUD7irtfcdY=";
  };
  cargoHash = "sha256-zNRrmHGHGIYnZRpOZfykGcyhICCYvwqKe36aHWFFidI=";
  cargoBuildFlags = [ "-p" "scip-tree-sitter" ];
  meta = {
    description = "Syntax-highlighting SCIP generator using Tree-sitter";
    homepage = "https://github.com/jelmer/scip-tools";
    license = pkgs.lib.licenses.asl20;
    mainProgram = "scip-tree-sitter";
  };
}
