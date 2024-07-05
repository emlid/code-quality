#!/bin/bash

# Default directories to check
DIRS_TO_CHECK="include"
EXCLUDED_DIRS=""

for i in "$@"
do
case $i in
    -f|--fix)
    FIX=true
    shift
    ;;
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

if [ ! -f .clang-format ]; then
    echo ".clang-format not found! Make ./code-quality/cpp/clang/setup-clang-config.sh to fix it."
    exit 1
fi

CLANG_FORMAT_BIN=clang-format-17

FIND_CMD="find"
for DIR in $DIRS_TO_CHECK; do
    FIND_CMD+=" $DIR"
done

FIND_CMD+=" -type f \( -name '*.h' -or -name '*.cpp' -or -name '*.cc' -or -name '*.c' \)"

for EX_DIR in $EXCLUDED_DIRS; do
    FIND_CMD+=" -not -path '$EX_DIR/*'"
done

SRC_TO_CHECK=$(eval $FIND_CMD)

if [[ ! $FIX ]]; then
    $CLANG_FORMAT_BIN -style=file -output-replacements-xml $SRC_TO_CHECK | grep "<replacement " > /dev/null 2>&1

    if [[ $? -eq 0 ]]; then
        echo "Clang-format detected non-compliant code, please fix it by calling me again with '--fix' flag"
        exit 1
    fi
else
    for file in $SRC_TO_CHECK
    do
        echo "$file fixing..."
        $CLANG_FORMAT_BIN -style=file -i $file
    done
fi
