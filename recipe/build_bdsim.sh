#!/usr/bin/env bash
set -eux

if [[ "$target_platform" == "osx-arm64" ]]; then
    wget https://github.com/bdsim-collaboration/mac_root/releases/download/v0.0.1/root-macOS-13-v6-34-04.tgz
    tar zxf root-macOS-13-v6-34-04.tgz
    otool -L ./root-v6-34-04/bin/rootcint
    install_name_tool -add_rpath @executable_path/../lib ./root-v6-34-04/bin/rootcint
    install_name_tool -change /usr/local/opt/zstd/lib/libzstd.1.dylib @executable_path/../lib/libzstd.1.dylib ./root-v6-34-04/lib/libCling.so
fi

mkdir bdsim-build
cd bdsim-build

if [[ "$target_platform" == "osx-arm64" ]]; then
    cmake $CMAKE_ARGS -DCMAKE_PREFIX_PATH=${PREFIX}/lib/cmake/Geant4/ \
	  -DCMAKE_INSTALL_PREFIX="${PREFIX}" "${SRC_DIR}" \
	  -DROOTCINT_EXECUTABLE=../root-v6-34-04/bin/rootcint
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
