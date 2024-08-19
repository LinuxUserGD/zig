#!/bin/sh

set -eu

ROOTDIR="$(pwd)"
TARGET_OS_CMAKE=""
mkdir -p "$ROOTDIR/out/build-zig-host"
mkdir -p "$ROOTDIR/out/host"
cd "$ROOTDIR/out/build-zig-host"
cmake "$ROOTDIR/zig" \
  -DCMAKE_INSTALL_PREFIX="$ROOTDIR/out/host" \
  -DCMAKE_PREFIX_PATH="$ROOTDIR/out/host" \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_C_COMPILER="clang" \
  -DCMAKE_CXX_COMPILER="clang++" \
  -DCMAKE_EXE_LINKER_FLAGS="-fuse-ld=mold" \
  -DZIG_STATIC_ZSTD=ON \
  -DZIG_STATIC_ZLIB=ON \
  -DZIG_SYSTEM_LIBCXX="c++" \
  -DZIG_TARGET_DYNAMIC_LINKER="/system/bin/linker64" \
  -DCMAKE_GENERATOR=Ninja
cmake --build . --target install
ZIG="$ROOTDIR/out/host/bin/zig"
