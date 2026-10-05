{ pkgs, packages }:
let
  inherit (pkgs) lib;
  # Swift and Zig do not build (see their files); skip anything unsupported here,
  # e.g. scip-clang and scip-ruby have no aarch64-linux release.
  indexers = lib.filter (lib.meta.availableOn pkgs.stdenv.hostPlatform)
    (builtins.attrValues (removeAttrs packages [ "scip-swift" "scip-zig" ]));

  entrypoint = pkgs.writeShellScriptBin "entrypoint" ''
    [ "''${1-}" = -- ] && shift
    if [ $# -eq 0 ]; then
      echo 'usage: docker run --rm -v "$PWD:/src" ghcr.io/smallstepman/scip-indexers -- <indexer> [args...]'
      echo 'indexers:'
      ${lib.concatMapStrings (p: "echo '  ${baseNameOf (lib.getExe p)}'\n") indexers}
      exit 64
    fi
    exec "$@"
  '';
in
pkgs.dockerTools.streamLayeredImage {
  name = "ghcr.io/smallstepman/scip-indexers";
  tag = "latest";
  contents = indexers ++ (with pkgs; [
    bashInteractive
    coreutils
    findutils
    gnugrep
    gnused
    git
    dockerTools.caCertificates
    dockerTools.fakeNss
    # Toolchains the indexers shell out to.
    go # scip-go
    jdk21 gradle maven # scip-java
    cargo rustc # rust-analyzer scip
    (python3.withPackages (ps: [ ps.pip ])) # scip-python shells out to pip
  ]);
  extraCommands = "mkdir -m 1777 tmp";
  config = {
    Entrypoint = [ (lib.getExe entrypoint) ];
    WorkingDir = "/src";
    Env = [
      "HOME=/tmp"
      "RUST_SRC_PATH=${pkgs.rustPlatform.rustLibSrc}"
    ];
    Labels."org.opencontainers.image.source" = "https://github.com/smallstepman/scip-indexers.nix";
  };
}
