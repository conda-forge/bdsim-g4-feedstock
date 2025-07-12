#!/usr/bin/env bash
set -eux

bdsim --help

bdsim --file=${RECIPE_DIR}/drift.gmad --batch --ngenerate=100 
