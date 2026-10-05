{ pkgs }:
pkgs.rustPlatform.buildRustPackage {
  pname = "scip-shell";
  version = "unstable-2026-09-20";
  src = pkgs.fetchFromGitHub {
    owner = "jelmer";
    repo = "scip-shell";
    rev = "c8b292cdf577c5d514a26a9241b4b124b251a354";
    hash = "sha256-xVxQ3xTpTfQi+rcAyron/ZBIBkaPXmTS3eL5KN4RxzI=";
  };
  cargoHash = "sha256-h5cTI0Gjvfhk49ZNsT8FTagLt0F6/lWjVYXYqaoTOd0=";
  meta = {
    description = "SCIP generator for shell scripts";
    homepage = "https://github.com/jelmer/scip-shell";
    license = pkgs.lib.licenses.mit;
    mainProgram = "scip-shell";
  };
}
