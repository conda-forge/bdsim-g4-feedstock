#!/usr/bin/env bash
set -eux

tar zxf root_v6.36.00.macos-14.7-x86_64-clang160.tar.gz
source ./root/bin/thisroot.sh 

mkdir bdsim-build
cd bdsim-build

cmake $CMAKE_ARGS -DCMAKE_PREFIX_PATH=${PREFIX}/lib/cmake/Geant4/ \
      -DCMAKE_INSTALL_PREFIX="${PREFIX}" "${SRC_DIR}"


make "-j${CPU_COUNT}" ${VERBOSE_CM:-}
make install "-j${CPU_COUNT}"

# Remove the geant4.(c)sh scripts and replace with a dummy version
rm "${PREFIX}/bin/bdsim.sh"
cp "${RECIPE_DIR}/bdsim.sh" "${PREFIX}/bin/bdsim.sh"
chmod +x "${PREFIX}/bin/bdsim.sh"
