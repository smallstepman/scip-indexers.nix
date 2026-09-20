#!/usr/bin/env bash

hello() {
  local name="$1"
  printf 'Hello, %s!\n' "$name"
}

hello world
