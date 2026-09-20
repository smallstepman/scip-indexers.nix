{ pkgs }:
let
  packageJson = pkgs.writeText "package.json" ''
    {
      "name": "scip-typescript",
      "version": "0.4.0",
      "dependencies": {
        "commander": "12.1.0",
        "google-protobuf": "3.21.4",
        "progress": "2.0.3",
        "typescript": "5.9.3"
      }
    }
  '';
  npmLock = pkgs.writeText "package-lock.json" ''
    {
      "name": "scip-typescript",
      "version": "0.4.0",
      "lockfileVersion": 3,
      "requires": true,
      "packages": {
        "": {
          "name": "scip-typescript",
          "version": "0.4.0",
          "dependencies": {
            "commander": "12.1.0",
            "google-protobuf": "3.21.4",
            "progress": "2.0.3",
            "typescript": "5.9.3"
          }
        },
        "node_modules/commander": {
          "version": "12.1.0",
          "resolved": "https://registry.npmjs.org/commander/-/commander-12.1.0.tgz",
          "integrity": "sha512-Vw8qHK3bZM9y/P10u3Vib8o/DdkvA2OtPtZvD871QKjy74Wj1WSKFILMPRPSdUSx5RFK1arlJzEtA4PkFgnbuA=="
        },
        "node_modules/google-protobuf": {
          "version": "3.21.4",
          "resolved": "https://registry.npmjs.org/google-protobuf/-/google-protobuf-3.21.4.tgz",
          "integrity": "sha512-MnG7N936zcKTco4Jd2PX2U96Kf9PxygAPKBug+74LHzmHXmceN16MmRcdgZv+DGef/S9YvQAfRsNCn4cjf9yyQ=="
        },
        "node_modules/progress": {
          "version": "2.0.3",
          "resolved": "https://registry.npmjs.org/progress/-/progress-2.0.3.tgz",
          "integrity": "sha512-7PiHtLll5LdnKIMw100I+8xJXR5gW2QwWYkT6iJva0bXitZKa/XMrSbdmg3r2Xnaidz9Qumd0VPaMrZlF9V9sA=="
        },
        "node_modules/typescript": {
          "version": "5.9.3",
          "resolved": "https://registry.npmjs.org/typescript/-/typescript-5.9.3.tgz",
          "integrity": "sha512-jl1vZzPDinLr9eUt3J/t7V6FgNEw9QjvBPdysz9KfQDD41fQrC2Y4vKQdiaUpFT4bXlb1RHhLpp8wtm6M5TgSw=="
        }
      }
    }
  '';
  npmSrc = pkgs.runCommand "scip-typescript-npm-src" {} ''
    mkdir -p $out
    cp ${packageJson} $out/package.json
    cp ${npmLock} $out/package-lock.json
  '';
  nodeModules = pkgs.buildNpmPackage {
    pname = "scip-typescript-node-modules";
    version = "0.4.0";
    src = npmSrc;
    npmDepsHash = "sha256-vTDxrAvhG0mOGGkcjaqsoE/EHtX2Z+wk2b02qkzMeTQ=";
    dontNpmBuild = true;
  };
in
pkgs.stdenvNoCC.mkDerivation {
  pname = "scip-typescript";
  version = "0.4.0";
  src = pkgs.fetchurl {
    url = "https://registry.npmjs.org/@sourcegraph/scip-typescript/-/scip-typescript-0.4.0.tgz";
    hash = "sha256-+kyDmDk9J0PhMG/cfqzPqv5IhpC7/tSBNUq79aM1Wbk=";
  };
  sourceRoot = "package";
  nativeBuildInputs = [ pkgs.nodejs_22 pkgs.makeWrapper ];
  installPhase = ''
    mkdir -p $out/lib/node_modules/@sourcegraph/scip-typescript $out/bin
    cp -r . $out/lib/node_modules/@sourcegraph/scip-typescript
    cp -r ${nodeModules}/lib/node_modules/scip-typescript/node_modules $out/lib/node_modules/@sourcegraph/scip-typescript/
    makeWrapper ${pkgs.nodejs_22}/bin/node $out/bin/scip-typescript \
      --add-flags "$out/lib/node_modules/@sourcegraph/scip-typescript/dist/src/main.js"
  '';
  meta = {
    description = "SCIP indexer for TypeScript and JavaScript";
    homepage = "https://github.com/sourcegraph/scip-typescript";
    license = pkgs.lib.licenses.asl20;
    mainProgram = "scip-typescript";
  };
}
