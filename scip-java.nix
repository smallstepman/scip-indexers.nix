{ pkgs }:
pkgs.stdenvNoCC.mkDerivation {
  pname = "scip-java";
  version = "0.13.1";
  src = pkgs.fetchurl {
    url = "https://github.com/scip-code/scip-java/releases/download/v0.13.1/scip-java-v0.13.1";
    hash = "sha256-ppTK4UPDLFtiJjYvtL0mio0T082bSCgZs7ACmpqXuP4=";
  };
  dontUnpack = true;
  installPhase = ''
    install -Dm755 $src $out/bin/scip-java
  '';
  meta = {
    description = "SCIP indexer for Java and Kotlin";
    homepage = "https://github.com/scip-code/scip-java";
    license = pkgs.lib.licenses.asl20;
    mainProgram = "scip-java";
  };
}
