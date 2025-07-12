#!/usr/bin/env bash
set -eux

bdsim --help

bdsim --file=drift.gmad --batch --ngenerate=100 
