#! /bin/bash

source scripts/source/html_library.sh
source scripts/source/common_library.sh

RESOURCES_PATH="resources_800"
DATA_FILE_PATH="resources_800/pokemon.csv"
HTML_DIR_PATH="html"

create_setup "${RESOURCES_PATH}" "${DATA_FILE_PATH}" "${HTML_DIR_PATH}"
main "${DATA_FILE_PATH}" "${HTML_DIR_PATH}"

open ${HTML_DIR_PATH}/all.html