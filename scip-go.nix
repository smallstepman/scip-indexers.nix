{ pkgs }:
pkgs.buildGoModule {
  pname = "scip-go";
  version = "unstable-2026-09-20";
  src = pkgs.fetchFromGitHub {
    owner = "scip-code";
    repo = "scip-go";
    rev = "343fa9ce00444421071d3659443a78cbfab3291f";
    hash = "sha256-EccsTsTTwAByMyHrnc9vLj6+SCG+XEk2/b4x7Hzlct4=";
  };
  vendorHash = "sha256-M5b05gKe39o5f1dCXrtKoXT9I70IVeCldE2JKDQPr4E=";
  doCheck = false;
  meta = {
    description = "SCIP indexer for Go";
    homepage = "https://github.com/scip-code/scip-go";
    license = pkgs.lib.licenses.asl20;
    mainProgram = "scip-go";
  };
}
