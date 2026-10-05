{ pkgs }:
let
  # Upstream only publishes these two prebuilt binaries.
  assets = {
    aarch64-darwin = { name = "arm64-darwin"; hash = "sha256-Ieria1RAKwQhS6Xm9gFMn2sPo5Q1KCXzPrYxRmbavXk="; };
    x86_64-linux = { name = "x86_64-linux"; hash = "sha256-ElmCwntZ+PNebrKQRxh4mkvfKLBje6rZUyl3dptgWKc="; };
  };
  asset = assets.${pkgs.stdenv.hostPlatform.system} or assets.x86_64-linux;
in
pkgs.stdenv.mkDerivation {
  pname = "scip-ruby";
  version = "0.4.8";
  src = pkgs.fetchurl {
    url = "https://github.com/sourcegraph/scip-ruby/releases/download/scip-ruby-v0.4.8/scip-ruby-${asset.name}";
    inherit (asset) hash;
  };
  dontUnpack = true;
  nativeBuildInputs = pkgs.lib.optionals pkgs.stdenv.hostPlatform.isLinux [ pkgs.autoPatchelfHook ];
  installPhase = ''
    install -Dm755 $src $out/bin/scip-ruby
  '';
  meta = {
    description = "SCIP indexer for Ruby";
    homepage = "https://github.com/sourcegraph/scip-ruby";
    license = pkgs.lib.licenses.asl20;
    mainProgram = "scip-ruby";
    platforms = builtins.attrNames assets;
  };
}
