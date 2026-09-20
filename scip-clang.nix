{ pkgs }:
pkgs.stdenvNoCC.mkDerivation {
  pname = "scip-clang";
  version = "0.4.0";
  src = pkgs.fetchurl {
    url = "https://github.com/sourcegraph/scip-clang/releases/download/v0.4.0/scip-clang-${if pkgs.stdenv.hostPlatform.isDarwin then "arm64-darwin" else "x86_64-linux"}";
    hash = if pkgs.stdenv.hostPlatform.isDarwin then "sha256-/wQvvIoCnwn0tp/HaS4pDiHFKSNZMgfuUtTnQ5Rz7GQ=" else "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };
  dontUnpack = true;
  installPhase = ''
    install -Dm755 $src $out/bin/scip-clang
  '';
  meta = {
    description = "SCIP indexer for C and C++";
    homepage = "https://github.com/sourcegraph/scip-clang";
    license = pkgs.lib.licenses.asl20;
    mainProgram = "scip-clang";
  };
}
