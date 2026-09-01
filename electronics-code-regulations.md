#!/bin/bash
# Self-displaying markdown reference of Electrical Code
# Add entries below the '##CUT' line

ourpath=$(readlink -f "$0") # Get our absolute path
echo "$ourpath"

# Find the line number where the markdown starts
# We use +1 to start reading immediately after the ##CUT marker
start_line=$(awk '/^##CUT/ {print NR + 1; exit}' "$ourpath")

# Fallback if the marker is not found
if [ -z "$start_line" ]; then
    echo "Error: ##CUT marker not found." >&2
    exit 1
fi

# Function to extract the markdown content
get_markdown() {
    tail -n +"$start_line" "$ourpath"
}

# Determine the best available syntax highlighter
if command -v mdcat &> /dev/null; then
    highlighter="mdcat"
elif command -v bat &> /dev/null; then
    highlighter="bat -l md --color=always"
elif command -v pygmentize &> /dev/null; then
    highlighter="pygmentize -l md"
else
    highlighter="cat"
fi

# Determine the best available pager
if command -v less &> /dev/null; then
    # -R allows ANSI color codes to pass through
    # -F exits immediately if the content fits on one screen
    # -X prevents clearing the screen on exit
    pager="less -RX"
else
    pager="cat"
fi

echo -e '\033[2J'
get_markdown | $highlighter | $pager
exit

##CUT
# Electrical Code

**California Electrical Code (CEC):**
[Title 24, Part 3 of the
*California Code of Regulations*](https://www.dgs.ca.gov/bsc/codes)
