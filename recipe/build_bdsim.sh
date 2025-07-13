#!/usr/bin/env bash
set -eux

if [[ "$target_platform" == "osx-arm64" ]]; then
    wget https://root.cern/download/root_v6.36.00.macos-14.7-x86_64-clang160.tar.gz
    tar zxf ./root_v6.36.00.macos-14.7-x86_64-clang160.tar.gz
fi

mkdir bdsim-build
cd bdsim-build

if [[ "$target_platform" == "osx-arm64" ]]; then
    cmake $CMAKE_ARGS -DCMAKE_PREFIX_PATH=${PREFIX}/lib/cmake/Geant4/ \
	  -DCMAKE_INSTALL_PREFIX="${PREFIX}" "${SRC_DIR}" \
	  -DROOTCINT_EXECUTABLE=./root/bin/rootcint/
else
    cmake $CMAKE_ARGS -DCMAKE_PREFIX_PATH=${PREFIX}/lib/cmake/Geant4/ \
	  -DCMAKE_INSTALL_PREFIX="${PREFIX}" "${SRC_DIR}"
fi

make "-j${CPU_COUNT}" ${VERBOSE_CM:-}
make install "-j${CPU_COUNT}"

# Remove the geant4.(c)sh scripts and replace with a dummy version
rm "${PREFIX}/bin/bdsim.sh"
cp "${RECIPE_DIR}/bdsim.sh" "${PREFIX}/bin/bdsim.sh"
chmod +x "${PREFIX}/bin/bdsim.sh"
