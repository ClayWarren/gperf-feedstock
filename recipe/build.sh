#!/bin/bash
set -exo pipefail

# Get an updated config.sub and config.guess
if [[ "${target_platform:-}" != win-* ]]; then
  cp "$BUILD_PREFIX"/share/gnuconfig/config.* ./build-aux
fi

export CXXFLAGS="${CXXFLAGS} -Wno-register"

./configure --prefix="${PREFIX}"
make -j${CPU_COUNT}
if [[ "$CONDA_BUILD_CROSS_COMPILATION" != 1 || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
    make -j 1 check
fi
make install
