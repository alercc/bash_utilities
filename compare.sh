#!/bin/bash

# -------------------------------------------------------------------------------------------------------------------
# THIS FILE DEFINES A FUNCTION WHICH CAN COMPARE FILES WHICH HAVE THE *SAME NAME* BUT LIVE IN DIFFERENT *FOLDERS*
# SYNTAX:    ./compare.sh    path_to_folder_1    path_to_folder_2    file_1    file_2    file_3    file_4    ...
# -------------------------------------------------------------------------------------------------------------------

# Check if at least three arguments are provided
if [ "$#" -lt 3 ]; then
    echo "Usage: $0 <directory1> <directory2> <file1> [<file2> ...]"
    exit 1
fi

# Source directories
dir1=$1
dir2=$2

# Remove the first two arguments (dir1 and dir2)
shift 2

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No color

# Print table header
printf "\n%-30s | %-10s\n" "File" "Status"
printf "%-30s | %-10s\n" "------------------------------" "----------"

# Iterate over the provided files
for file in "$@"; do
    file1="$dir1/$file"
    file2="$dir2/$file"

    # Check if the files exist
    if [[ ! -e $file1 ]]; then
        printf "%-30s | %-10s\n" "$file" "Missing in $dir1"
        continue
    fi

    if [[ ! -e $file2 ]]; then
        printf "%-30s | %-10s\n" "$file" "Missing in $dir2"
        continue
    fi

    # Compare the files using diff
    if diff -q "$file1" "$file2" > /dev/null; then
        printf "%-30s | ${GREEN}%-10s${NC}\n" "$file" "identical"
    else
        printf "%-30s | ${RED}%-10s${NC}\n" "$file" "DIFFERENT"
    fi
done

printf "%-30s | %-10s\n" "------------------------------" "----------"
