{ pkgs }:
pkgs.stdenvNoCC.mkDerivation {
  pname = "scip-ruby";
  version = "0.4.8";
  src = pkgs.fetchurl {
    url = "https://github.com/sourcegraph/scip-ruby/releases/download/scip-ruby-v0.4.8/scip-ruby-arm64-darwin";
    hash = "sha256-Ieria1RAKwQhS6Xm9gFMn2sPo5Q1KCXzPrYxRmbavXk=";
  };
  dontUnpack = true;
  installPhase = ''
    install -Dm755 $src $out/bin/scip-ruby
  '';
  meta = {
    description = "SCIP indexer for Ruby";
    homepage = "https://github.com/sourcegraph/scip-ruby";
    license = pkgs.lib.licenses.asl20;
    mainProgram = "scip-ruby";
  };
}
