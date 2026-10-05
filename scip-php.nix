{ pkgs }:
pkgs.php.buildComposerProject2 {
  pname = "scip-php";
  version = "0.0.0";
  src = pkgs.fetchFromGitHub {
    owner = "davidrjenni";
    repo = "scip-php";
    rev = "71a5b117ec4c5dd2af302e363410e604e5df309e";
    hash = "sha256-O0+k+UkW1mKFBv4tB8xsH6/zoOQXNnncGJDrsrJI3x4=";
  };
  vendorHash = "sha256-CrrJM1SLWAQHHdY7s2LPmaR8an02ydCtVdcKomcBMtY=";
  php = pkgs.php83;
  meta = {
    description = "SCIP indexer for PHP";
    homepage = "https://github.com/davidrjenni/scip-php";
    license = pkgs.lib.licenses.mit;
    mainProgram = "scip-php";
  };
}
