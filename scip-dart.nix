{ pkgs }:
pkgs.buildDartApplication {
  pname = "scip_dart";
  version = "1.6.2";
  src = pkgs.fetchFromGitHub {
    owner = "Workiva";
    repo = "scip-dart";
    rev = "5b37dc9a71dc255556bf4f3cefe967ac8e6e08f2";
    hash = "sha256-N7UWNjlm7i0R6xzh51k1IfSB4kGW7surEMEzE+sBCIg=";
  };
  # Upstream does not commit pubspec.lock; regenerate with `dart pub get` and
  # `yq -o=json . pubspec.lock` when bumping `rev`.
  pubspecLock = pkgs.lib.importJSON ./scip-dart-pubspec.lock.json;
  dartEntryPoints."bin/scip_dart" = "bin/scip_dart.dart";
  meta = {
    description = "SCIP indexer for Dart";
    homepage = "https://github.com/Workiva/scip-dart";
    license = pkgs.lib.licenses.asl20;
    mainProgram = "scip_dart";
  };
}
