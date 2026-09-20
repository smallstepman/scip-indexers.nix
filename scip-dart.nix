{ pkgs }:
pkgs.stdenvNoCC.mkDerivation {
  pname = "scip_dart";
  version = "1.6.2";
  src = pkgs.fetchFromGitHub {
    owner = "Workiva";
    repo = "scip-dart";
    rev = "master";
    hash = "sha256-N7UWNjlm7i0R6xzh51k1IfSB4kGW7surEMEzE+sBCIg=";
  };
  nativeBuildInputs = [ pkgs.dart pkgs.darwin.sigtool pkgs.darwin.cctools ];
  buildPhase = ''
    export PUB_CACHE=$TMPDIR/pub-cache
    dart pub get
    dart compile exe bin/scip_dart.dart -o scip_dart
  '';
  installPhase = ''
    install -Dm755 scip_dart $out/bin/scip_dart
  '';
  meta = {
    description = "SCIP indexer for Dart";
    homepage = "https://github.com/Workiva/scip-dart";
    license = pkgs.lib.licenses.asl20;
    mainProgram = "scip_dart";
  };
}
