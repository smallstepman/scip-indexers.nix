{ pkgs }:
pkgs.rustPlatform.buildRustPackage {
  pname = "scip-protobuf";
  version = "unstable-2026-09-20";
  src = pkgs.fetchFromGitHub {
    owner = "sourcegraph";
    repo = "scip-protobuf";
    rev = "main";
    hash = "sha256-mNuquClnfZ/qgX3cZOQ8gDuEv1Klw1MJ81mKNLi7ecA=";
  };
  cargoHash = "sha256-vJJjv6WEyEJOOUuWCH9hFkUCP9uC3ZRJQlB13HRrK3E=";
  meta = {
    description = "SCIP indexer for Protocol Buffers";
    homepage = "https://github.com/sourcegraph/scip-protobuf";
    license = pkgs.lib.licenses.asl20;
    mainProgram = "scip-protobuf";
  };
}
