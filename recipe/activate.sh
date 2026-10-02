if [ -z "$ROOT_INCLUDE_PATH" ]; then
    export ROOT_INCLUDE_PATH=${CONDA_PREFIX}/include/bdsim/:${CONDA_PREFIX}/include/bdsim/analysis/:${CONDA_PREFIX}/include/bdsim/parser/
else
    export ROOT_INCLUDE_PATH=${ROOT_INCLUDE_PATH}:${CONDA_PREFIX}/include/bdsim/:${CONDA_PREFIX}/include/bdsim/analysis/:${CON\
DA_PREFIX}/include/bdsim/parser/
fi

if [ -z "$PYTHONPATH" ]; then   
    export PYTHONPATH=${CONDA_PREFIX}/lib/bdsim-python/
else
    export PYTHONPATH=${PYTHONPATH}:${CONDA_PREFIX}/lib/bdsim-python/
fi

