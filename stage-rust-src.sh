#!/usr/bin/env bash

set -euo pipefail

if [ -z "${1-}" ]; then
	echo "Usage: $0 <path/to/build/host/stage3>"
	exit 1
fi

set -x

cd "${1}/lib/rustlib"

mv rustc-src/rust rustc-src/rust_
mv src/rust src/rust_
mkdir rustc-src/rust
mkdir -p src/rust/src/llvm-project

rsync -av rustc-src/rust_/compiler/ rustc-src/rust/compiler/
rsync -av src/rust_/src/llvm-project/libunwind src/rust/src/llvm-project/libunwind
rsync -av src/rust_/library/ src/rust/library/

rm rustc-src/rust_
rm src/rust_

set +x