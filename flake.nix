{
  description = "scip-indexers.nix: Nix packages for SCIP language indexers";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;

      packagesFor = system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          packages = {
            scip-clang = import ./scip-clang.nix { inherit pkgs; };
            scip-dart = import ./scip-dart.nix { inherit pkgs; };
            scip-diff = import ./scip-diff.nix { inherit pkgs; };
            scip-dotnet = import ./scip-dotnet.nix { inherit pkgs; };
            scip-go = import ./scip-go.nix { inherit pkgs; };
            scip-java = import ./scip-java.nix { inherit pkgs; };
            scip-perl = import ./scip-perl.nix { inherit pkgs; };
            scip-php = import ./scip-php.nix { inherit pkgs; };
            scip-protobuf = import ./scip-protobuf.nix { inherit pkgs; };
            scip-psql = import ./scip-psql.nix { inherit pkgs; };
            scip-python = import ./scip-python.nix { inherit pkgs; };
            scip-ruby = import ./scip-ruby.nix { inherit pkgs; };
            scip-rust = import ./scip-rust.nix { inherit pkgs; };
            scip-shell = import ./scip-shell.nix { inherit pkgs; };
            scip-typescript = import ./scip-typescript.nix { inherit pkgs; };
            scip-tree-sitter = import ./scip-tree-sitter.nix { inherit pkgs; };
            scip-swift = import ./scip-swift.nix { inherit pkgs; };
            scip-zig = import ./scip-zig.nix { inherit pkgs; };
          };
        in packages // {
          scip-indexers = pkgs.symlinkJoin {
            name = "scip-indexers";
            # Swift and Zig are intentionally included even though their current
            # upstream sources do not build with the toolchain in nixpkgs.
            paths = builtins.attrValues packages;
          };
        };
    in {
      packages = forAllSystems packagesFor;
      apps = forAllSystems (system: {
        default = {
          type = "app";
          program = "${(packagesFor system).scip-indexers}/bin/scip-go";
        };
      });
    };
}
