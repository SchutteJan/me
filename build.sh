#!/bin/bash

# Check if pandoc is installed
if ! command -v pandoc &> /dev/null; then
    echo "Error: pandoc is not installed. Please install pandoc to continue."
    exit 1
fi

# Process index.md (home page)
if [ -f "index.md" ]; then
    echo "Processing index.md..."
    pandoc "index.md" \
        --template=template.html \
        --variable=is_home:true \
        --output="index.html"
    echo "Generated index.html"
fi

# Process each markdown file in posts directory
for md_file in posts/*.md; do
    if [ -f "$md_file" ]; then
        echo "Processing $md_file..."

        # Extract filename without extension for slug
        basename=$(basename "$md_file" .md)

        # Convert markdown to HTML using pandoc with template
        pandoc "$md_file" \
            --template=template.html \
            --variable=slug:"$basename" \
            --output="posts/$basename.html"

        echo "Generated posts/$basename.html"
    fi
done

echo "Build complete!"
