#!/bin/bash

# Default directories to check
DIRS_TO_CHECK="include"
EXCLUDED_DIRS=""

CONFIG_FILE="code-quality/cpp/clang/.clang-tidy"

for i in "$@"
do
case $i in
    --include-dirs=*)
    DIRS_TO_CHECK="${i#*=}"
    shift
    ;;
    --exclude-dirs=*)
    EXCLUDED_DIRS="${i#*=}"
    shift
    ;;
    *)
    echo "Not supported arg"
    exit 1
    ;;
esac
done

FIND_CMD="find"
for DIR in $DIRS_TO_CHECK; do
    FIND_CMD+=" $DIR"
done

FIND_CMD+=" -type f \( -name '*.h' -or -name '*.cpp' -or -name '*.cc' -or -name '*.c' \)"

for EX_DIR in $EXCLUDED_DIRS; do
    FIND_CMD+=" -not -path '$EX_DIR/*'"
done

SRC_TO_CHECK=$(eval $FIND_CMD)

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  NPROC="${NPROC:-$(nproc)}"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  NPROC="${NPROC:-$(sysctl -n hw.physicalcpu)}"
else
  NPROC="${NPROC:-1}"
fi

run-clang-tidy-17 \
    -j "${NPROC}" \
    -clang-tidy-binary clang-tidy-17 \
    -config-file=$CONFIG_FILE \
    -clang-apply-replacements-binary clang-apply-replacements-17 \
    -p build \
    $SRC_TO_CHECK
