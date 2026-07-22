#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

git submodule update --init --recursive
(
  cd libwg
  ./build.sh
)
cargo build --release

ARTIFACT="$(mktemp)"
cp target/release/corplink-rs "$ARTIFACT"
rm -rf target
mkdir -p target/release
mv "$ARTIFACT" target/release/corplink-rs
chmod +x target/release/corplink-rs
rm -f libwg/libwg.a libwg/libwg.h

echo "Build complete: target/release/corplink-rs"
