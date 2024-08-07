#!/usr/bin/env bash

# Check if both arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <test_folder> <allowed_functions>"
    exit 1
fi

# Extract arguments
test_folder="$1"
allowed_functions="$2"

# Replace commas with spaces in allowed_functions
allowed_functions=$(echo "$allowed_functions" | tr ',' ' ')

# Run the test script
./test_one.sh "$test_folder"
echo "$test_folder test executed!"

# Determine the correct path for the Go script
go_file=""
if [ -f "../piscine-go/$test_folder/main.go" ]; then
    go_file=$(realpath "../piscine-go/$test_folder/main.go")
elif [ -f "../piscine-go/$test_folder.go" ]; then
    go_file=$(realpath "../piscine-go/$test_folder.go")
else
    echo "Error: Neither '../piscine-go/$test_folder/main.go' nor '../piscine-go/$test_folder.go' exists."
    exit 1
fi

# Run the restrictions checker with the specified allowed functions
./rc "$go_file" $allowed_functions
