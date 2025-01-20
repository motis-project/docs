#!/bin/bash

set -o errexit -o nounset -o pipefail

# Make this script parent directory the CWD:
cd $(dirname ${BASH_SOURCE[0]})
CONF_DIR=$PWD
cd ../..
export MOTIS_REPO_NAME=$(basename "$PWD")
if ! [ -d docs ]; then
    echo 'There must be a docs/ directory'
    exit 1
fi
cd docs
envsubst < "${CONF_DIR}/Doxyfile" | doxygen
envsubst < "${CONF_DIR}/conf.py" > conf.py
sphinx-build -M html . _build
mv _build/html ../public
