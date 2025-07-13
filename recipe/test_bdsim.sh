#!/usr/bin/env bash
set -eux

if [[ "$target_platform" == "osx-arm64" ]]; then
    echo "Skipping tests on osx-arm64"
    exit 0
else
    bdsim --help
    bdsim --file=${RECIPE_DIR}/drift.gmad --batch --ngenerate=100 
fi


