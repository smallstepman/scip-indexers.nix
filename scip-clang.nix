{ pkgs }:
let
  # Upstream only publishes these two prebuilt binaries.
  assets = {
    aarch64-darwin = { name = "arm64-darwin"; hash = "sha256-/wQvvIoCnwn0tp/HaS4pDiHFKSNZMgfuUtTnQ5Rz7GQ="; };
    x86_64-linux = { name = "x86_64-linux"; hash = "sha256-Bv0YxXb5eacmxlFZRkTsSjXbT0cfIWCz9y64n6YAF4Q="; };
  };
  asset = assets.${pkgs.stdenv.hostPlatform.system} or assets.x86_64-linux;
in
pkgs.stdenv.mkDerivation {
  pname = "scip-clang";
  version = "0.4.0";
  src = pkgs.fetchurl {
    url = "https://github.com/sourcegraph/scip-clang/releases/download/v0.4.0/scip-clang-${asset.name}";
    inherit (asset) hash;
  };
  dontUnpack = true;
  nativeBuildInputs = pkgs.lib.optionals pkgs.stdenv.hostPlatform.isLinux [ pkgs.autoPatchelfHook ];
  installPhase = ''
    install -Dm755 $src $out/bin/scip-clang
  '';
  meta = {
    description = "SCIP indexer for C and C++";
    homepage = "https://github.com/sourcegraph/scip-clang";
    license = pkgs.lib.licenses.asl20;
    mainProgram = "scip-clang";
    platforms = builtins.attrNames assets;
  };
}
