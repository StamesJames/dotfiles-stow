#!/usr/bin/fish
function move_mkvs
# Create the 'extras' folder if it doesn't exist
mkdir -p extras

# Loop through all .mkv files in the current directory
for file in *.mkv
    # Get the duration in seconds using ffprobe
    set duration (ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$file" 2>/dev/null)

    # Check if duration is valid and less than 600 seconds (10 minutes)
    if test -n "$duration" -a "$duration" -lt 600
        echo "Moving $file to extras (Duration: $duration seconds)"
        mv "$file" extras/
    end
end
end
