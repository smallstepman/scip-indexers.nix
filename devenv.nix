{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  # Use the flake's aggregate output; package definitions stay in flake.nix.
  packages = [
    pkgs.git
    inputs.scip-indexers.packages.${pkgs.system}.scip-indexers
  ];

  languages.perl.enable = true;
  languages.java.enable = true;
  languages.php.enable = true;
  languages.rust.enable = true;


  enterTest = ''
    ${./tests/index-fixtures.sh}
  '';
}
