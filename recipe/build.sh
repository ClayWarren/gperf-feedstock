#!/bin/bash
set -exo pipefail

# Get an updated config.sub and config.guess
if [[ "${GPERF_TARGET_PLATFORM:-}" == "win-arm64" ]]; then
  export build_alias=aarch64-w64-mingw32
  export host_alias=aarch64-w64-mingw32
elif [[ "${GPERF_TARGET_PLATFORM:-${target_platform:-}}" != win-* ]]; then
  cp "$BUILD_PREFIX"/share/gnuconfig/config.* ./build-aux
fi

export CXXFLAGS="${CXXFLAGS} -Wno-register"

./configure --prefix="${PREFIX}"
make -j${CPU_COUNT}
if [[ "$CONDA_BUILD_CROSS_COMPILATION" != 1 || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
    make -j 1 check
fi
make install
