{ pkgs }:
pkgs.stdenvNoCC.mkDerivation {
  pname = "scip-dotnet";
  version = "0.2.14";
  src = pkgs.fetchurl {
    url = "https://api.nuget.org/v3-flatcontainer/scip-dotnet/0.2.14/scip-dotnet.0.2.14.nupkg";
    hash = "sha256-4tGD/jm5pWy4uy7S2LloKPtUNMbbCEACv4pcYAk5G1I=";
  };
  nativeBuildInputs = [ pkgs.unzip pkgs.makeWrapper ];
  unpackPhase = ''
    mkdir source
    cd source
    unzip "$src"
  '';
  installPhase = ''
    mkdir -p "$out/lib/scip-dotnet" "$out/bin"
    cp -r . "$out/lib/scip-dotnet/"
    # scip-dotnet loads projects through MSBuild, which needs the SDK, not just the runtime.
    makeWrapper ${pkgs.dotnetCorePackages.sdk_10_0}/bin/dotnet "$out/bin/scip-dotnet" \
      --add-flags "$out/lib/scip-dotnet/tools/net10.0/any/scip-dotnet.dll"
  '';
  meta = {
    description = "SCIP indexer for C#";
    homepage = "https://github.com/sourcegraph/scip-dotnet";
    license = pkgs.lib.licenses.asl20;
    mainProgram = "scip-dotnet";
  };
}
