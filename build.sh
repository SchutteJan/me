#!/bin/bash

set -e

# Markdown Docs:
# https://pandoc.org/MANUAL.html#pandocs-markdown

# Check if pandoc is installed
if ! command -v pandoc &> /dev/null; then
    echo "Error: pandoc is not installed. Please install pandoc to continue."
    exit 1
fi
OUTPUT_DIR="./out"
mkdir -p "$OUTPUT_DIR"

# Copy static assets to out dir
cp static/* "$OUTPUT_DIR/"

# Process index.md (home page)
if [ -f "index.md" ]; then
    echo "Processing index.md..."
    pandoc "index.md" \
        --template=template.html \
        --variable=is_home:true \
        --output="$OUTPUT_DIR/index.html"
    echo "Generated index.html"
fi

# Process each post: flat posts/<slug>.md or folder posts/<slug>/index.md
for md_file in posts/*.md posts/*/index.md; do
    [ -f "$md_file" ] || continue
    echo "Processing $md_file..."

    # Folder posts use the directory name as slug and stay in the folder;
    # flat posts use the filename.
    if [ "$(basename "$md_file")" = "index.md" ]; then
        slug=$(basename "$(dirname "$md_file")")
        output="$OUTPUT_DIR/posts/$slug/index.html"
    else
        slug=$(basename "$md_file" .md)
        output="$OUTPUT_DIR/posts/$slug.html"
    fi

    mkdir -p $(dirname $output)

    pandoc "$md_file" \
        --template=template.html \
        --variable=slug:"$slug" \
        --output="$output"

    echo "Generated $output"
done

# Generate RSS feed from the "## Posts" section of index.md
if [ -f "index.md" ]; then
    echo "Generating feed.xml..."

    BASE_URL="https://janschutte.com"
    BUILD_DATE=$(date -R)

    {
        echo '<?xml version="1.0" encoding="UTF-8"?>'
        echo '<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">'
        echo '  <channel>'
        echo '    <title>Jan Schutte</title>'
        echo "    <link>$BASE_URL/</link>"
        echo '    <description>Posts by Jan Schutte</description>'
        echo '    <language>en</language>'
        echo "    <lastBuildDate>$BUILD_DATE</lastBuildDate>"
        echo "    <atom:link href=\"$BASE_URL/feed.xml\" rel=\"self\" type=\"application/rss+xml\" />"

        # Extract lines like: - [Title](url) _(YYYY-MM-DD)_ from the Posts section
        awk '/^## Posts/{f=1;next} /^## /{f=0} f' index.md \
            | grep -E '^- \[.*\]\(.*\) _\(.*\)_' \
            | while IFS= read -r line; do
                title=$(echo "$line" | sed -E 's/^\- \[(.*)\]\(.*/\1/')
                url=$(echo "$line" | sed -E 's/^\- \[.*\]\((.*)\) _\(.*/\1/')
                pubdate=$(echo "$line" | sed -E 's/.*_\((.*)\)_.*/\1/')

                # Resolve relative URLs against the base URL
                case "$url" in
                    http*) ;;
                    *) url="$BASE_URL/$url" ;;
                esac

                # Escape XML special characters in the title
                title=$(echo "$title" | sed -e 's/&/\&amp;/g' -e 's/</\&lt;/g' -e 's/>/\&gt;/g')

                rfc_date=$(date -R -d "$pubdate" 2>/dev/null || echo "$pubdate")

                echo '    <item>'
                echo "      <title>$title</title>"
                echo "      <link>$url</link>"
                echo "      <guid isPermaLink=\"true\">$url</guid>"
                echo "      <pubDate>$rfc_date</pubDate>"
                echo '    </item>'
            done

        echo '  </channel>'
        echo '</rss>'
    } > $OUTPUT_DIR/feed.xml

    echo "Generated feed.xml"
fi

echo "Build complete!"
