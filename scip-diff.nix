{ pkgs }:
pkgs.rustPlatform.buildRustPackage {
  pname = "scip-diff";
  version = "unstable-2026-09-20";
  src = pkgs.fetchFromGitHub {
    owner = "jelmer";
    repo = "diff-lsp";
    rev = "4f0a0a92263c20cd7a52c0e745a6afed6115217d";
    hash = "sha256-JaigxnjhrDVEiX3ROv2ZX9EhgzVwmXBQPfnYV4ylI2c=";
  };
  postInstall = ''
    ln -s $out/bin/diff-lsp $out/bin/scip-diff
  '';
  cargoHash = "sha256-9Eqsu1DiSBLPplPSzBaYYkiz4SDsaSQEUxZcHmbLPDU=";
  meta = {
    description = "Language server and SCIP producer for diff and patch files";
    homepage = "https://github.com/jelmer/diff-lsp";
    license = pkgs.lib.licenses.mit;
    mainProgram = "scip-diff";
  };
}
