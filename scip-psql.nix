{ pkgs }:
pkgs.rustPlatform.buildRustPackage {
  pname = "psql-scip";
  version = "0.2.0";
  src = pkgs.fetchFromGitHub {
    owner = "gnufood";
    repo = "psql-scip";
    rev = "63c672786eadb34aceb304e4432a3b6d8ad403c3";
    hash = "sha256-n4mK3GRrqv2IwtFynyvxXpIVoLKRfjQf2xMCmmQO7Ps=";
  };
  cargoHash = "sha256-o8dGWyNBdenbfa1+vrKai/QZKKWiF9FTGwz3abuJFWk=";
  # pg_query uses bindgen, which needs libclang (Darwin finds Xcode's).
  nativeBuildInputs = [ pkgs.rustPlatform.bindgenHook ];
  meta = {
    description = "SCIP indexer for PostgreSQL";
    homepage = "https://github.com/gnufood/psql-scip";
    license = pkgs.lib.licenses.mit;
    mainProgram = "psql-scip";
  };
}
