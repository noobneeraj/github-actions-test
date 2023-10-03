#!/bin/bash

# Get the current working directory.
cwd=$(pwd)

# Create a JSON file to store the details of the Contributors.
json_file="$cwd/.github/data/contribute.json"
echo "{" > "$json_file"

# Iterate over the subdirectories in the current working directory.
for subdir in "$cwd"/*; do

  # Check if the subdirectory is a directory.
  if [ -d "$subdir" ]; then

    # Get the name of the subdirectory.
    subdir_name=$(basename "$subdir")

    # Get the GitHub author name of the contributor who created the subdirectory.
    contributor_name=$(git log -1 --format="%an" "$subdir")

    # Get the pull request link for the pull request that added the subdirectory.
    pull_request=$(git log -1 --format="%b" "$subdir" | grep -o "https://github.com/[^/]+/[^/]+/pull/[0-9]+" | head -n 1)

    # Get the path to the index.html file in the subdirectory.
    index_html_path="$subdir/index.html"
    if [ ! -f "$index_html_path" ]; then
      index_html_path="https://github.com/Grow-with-Open-Source/tree/main/Javascript-Projects/$(basename "$subdir")"
    fi

    # Add the details of the subdirectory to the JSON file.
    echo "  \"$subdir_name\": {" >> "$json_file"
    echo "    \"contributor-name\": \"$contributor_name\"," >> "$json_file"
    echo "    \"pull-request\": \"$pull_request\"," >> "$json_file"
    echo "    \"path\": \"$index_html_path\"" >> "$json_file"
    echo "  }," >> "$json_file"

  fi

done

# Close the JSON file.
echo "}" >> "$json_file"

