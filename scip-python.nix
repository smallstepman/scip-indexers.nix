{ pkgs }:
pkgs.stdenvNoCC.mkDerivation {
  pname = "scip-python";
  version = "0.6.6";
  src = pkgs.fetchurl {
    url = "https://registry.npmjs.org/@sourcegraph/scip-python/-/scip-python-0.6.6.tgz";
    hash = "sha256-vo4KHsGAQjxg6fLCZywgj0mjWraQrA+PElnkIj29bkI=";
  };
  sourceRoot = "package";
  nativeBuildInputs = [ pkgs.nodejs_22 pkgs.makeWrapper ];
  installPhase = ''
    mkdir -p $out/lib/node_modules/@sourcegraph/scip-python $out/bin
    cp -r . $out/lib/node_modules/@sourcegraph/scip-python
    makeWrapper ${pkgs.nodejs_22}/bin/node $out/bin/scip-python \
      --add-flags "$out/lib/node_modules/@sourcegraph/scip-python/index.js"
  '';
  meta = {
    description = "SCIP indexer for Python";
    homepage = "https://github.com/sourcegraph/scip-python";
    license = pkgs.lib.licenses.mit;
    mainProgram = "scip-python";
  };
}
