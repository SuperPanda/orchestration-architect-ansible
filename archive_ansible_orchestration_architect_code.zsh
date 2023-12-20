#!/bin/zsh

# Set the name of the archive
archive_name="ansible_orchestration_architect.tar"

# Remove the previous archive if it exists
if [[ -f $archive_name ]]; then
  rm "$archive_name"
fi

# Create a new tar file of all .md and .yml files
find . -type f \( -name '*.yml' -o -name '*.md' \) -print0 | tar -cvf "$archive_name" --null -T -

# Provide instructions for an AI program to open
cat << EOF
The archive '$archive_name' has been created. To extract this archive, use the following command:

tar -xvf '$archive_name' -C /path/to/extract/

Replace '/path/to/extract/' with the actual directory where you want to extract the files.
EOF
