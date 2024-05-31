#!/bin/bash

if [ ! -f .clang-tidy ]; then
    echo ".clang-tidy not found! Make ./code-quality/cpp/clang/setup-clang-config.sh to fix it."
    exit 1
fi

# Default directories to check
DIRS_TO_CHECK="include"
EXCLUDED_DIRS=""

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

SRC_TO_CHECK=$(find ${DIRS_TO_CHECK} ${EXCLUDED_DIRS} -name "*.h" -or -name "*.cpp")

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
    -clang-apply-replacements-binary clang-apply-replacements-17 \
    -p build \
    $SRC_TO_CHECK
