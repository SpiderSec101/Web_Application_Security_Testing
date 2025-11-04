#!/bin/bash

# -----------------------------
# Configuration
# -----------------------------
SCREEN_DIR="./screens"  # Folder to watch
HTML_FILE="./index.html"     # Output HTML file
SLEEP_INTERVAL=5             # How often to check in seconds

# -----------------------------
# Function to generate HTML
# -----------------------------
generate_html() {
    local files=("$SCREEN_DIR"/*.png)

    # Start HTML
    cat > "$HTML_FILE" <<EOL
<html>
<head>
<title>Screenshot Index</title>
<link href="https://fonts.googleapis.com/css2?family=Fira+Code:wght@400;500;700&display=swap" rel="stylesheet">
<style>
body {font-family: 'Fira Code', monospace;}
table { border-collapse: collapse; width: 100%; margin: auto; }
th, td { border: 0.5px solid #f5f5f5; padding: 10px; text-align: center; font }
tr {background-color: black;}
th { background-color: black; color: white; }
img { max-width: 800px; max-height: 700px; }
</style>
</head>
<body style="background-color: black; color: white;">
<h2 style="margin: auto; text-align: center;">Screenshot Index</h2>
<table>
<tr><th>#</th><th>Host</th><th>Screenshot</th></tr>
EOL

        x=$(ls "$SCREEN_DIR" | wc -l)
        echo "<h3>Total Screenshots = $x</h3>" >> "$HTML_FILE"
    local index=1
    # Add a row for each PNG
    for file in "${files[@]}"; do
        [ -e "$file" ] || continue  # Skip if no files
        filename=$(basename "$file")
        name="${filename%.png}"
        # Remove http:// or https://
        name="${name#http.}"
        name="${name#https.}"

        echo "<tr><td><b>AHS$index<br>($x)</b></td><td>$name</td><td><a href='$SCREEN_DIR/$filename' target='_blank'><img src='$SCREEN_DIR/$filename'></a></td></tr>" >> "$HTML_FILE"
        ((index++))
    done

    # Close table
    echo "</table></body></html>" >> "$HTML_FILE"
}

# -----------------------------
# Continuous loop
# -----------------------------
echo "[*] Watching folder '$SCREEN_DIR' and updating $HTML_FILE every $SLEEP_INTERVAL seconds..."
while true; do
    generate_html
    sleep "$SLEEP_INTERVAL"
done
