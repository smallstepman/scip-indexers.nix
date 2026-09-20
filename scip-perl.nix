{ pkgs }:
pkgs.rustPlatform.buildRustPackage {
  pname = "scip-perl";
  version = "unstable-2026-09-20";
  src = pkgs.fetchFromGitHub {
    owner = "jelmer";
    repo = "scip-perl";
    rev = "master";
    hash = "sha256-Icyeu0UG+LYxDqgnNgkNUUIkCfuvyQRf9zsCbbt2e5c=";
  };
  cargoHash = "sha256-zoY9L4jvlp0JNlsJoJosnNsyE6HiVGLW+1j8dpg7oJA=";
  meta = {
    description = "SCIP generator for Perl";
    homepage = "https://github.com/jelmer/scip-perl";
    license = pkgs.lib.licenses.mit;
    mainProgram = "scip-perl";
  };
}
