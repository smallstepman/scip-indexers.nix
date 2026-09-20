#!/usr/bin/env bash
set -euo pipefail

run_indexer() {
  local name="$1"
  shift
  echo "indexing ${name}"
  "$@"
}

INDEX_STATE="$DEVENV_STATE/indexers"
rm -rf "$INDEX_STATE"
mkdir -p "$INDEX_STATE"
export DEVENV_STATE="$INDEX_STATE"

run_indexer go sh -c 'cd tests/fixtures/go && scip-go -o "$DEVENV_STATE/go.scip"'
run_indexer python sh -c 'scip-python index tests/fixtures/python --project-name hello-python --project-version 0.1.0 --output "$DEVENV_STATE/python.scip"'
run_indexer java sh -c 'cd tests/fixtures/java-kotlin && scip-java index --output "$DEVENV_STATE/java.scip" && test -s "$DEVENV_STATE/java.scip"'
run_indexer php sh -c 'cd tests/fixtures/php && composer install --no-interaction --no-progress >/dev/null && scip-php'
run_indexer rust sh -c 'cd tests/fixtures/rust && export CARGO_HOME="$DEVENV_STATE/cargo-home" CARGO_TARGET_DIR="$DEVENV_STATE/cargo-target" && cargo check --offline && rust-analyzer analysis-stats . >/dev/null'
run_indexer perl sh -c 'perl tests/fixtures/perl/hello.pl >/dev/null && scip-perl tests/fixtures/perl -o "$DEVENV_STATE/perl.scip"'
run_indexer psql sh -c 'psql-scip --schema tests/fixtures/sql/schema.sql --root tests/fixtures/sql --out "$DEVENV_STATE/psql.scip"'
run_indexer shell sh -c 'scip-shell --project-root tests/fixtures/shell tests/fixtures/shell -o "$DEVENV_STATE/shell.scip"'
run_indexer tree-sitter sh -c 'scip-tree-sitter --help >/dev/null'
run_indexer diff sh -c 'scip-diff --help >/dev/null'
test -d "$DEVENV_STATE"
