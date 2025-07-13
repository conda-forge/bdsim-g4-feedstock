#!/usr/bin/env bash
set -eux

if [[ "$target_platform" == "osx-arm64" ]]; then
    wget https://github.com/bdsim-collaboration/mac_root/releases/download/v0.0.1/root-macOS-13-v6-32-10.tgz
    tar zxf root-macOS-13-v6-32-10.tgz
fi

mkdir bdsim-build
cd bdsim-build

if [[ "$target_platform" == "osx-arm64" ]]; then
    cmake $CMAKE_ARGS -DCMAKE_PREFIX_PATH=${PREFIX}/lib/cmake/Geant4/ \
	  -DCMAKE_INSTALL_PREFIX="${PREFIX}" "${SRC_DIR}" \
	  -DROOTCINT_EXECUTABLE=../root-v6-32-10/bin/rootcint
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
