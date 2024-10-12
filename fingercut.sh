#!/bin/bash

# Define path to hashcat-utils and the working directory
hu_path="/opt/hashcat-utils/src"
work_path="/opt/cutb"
input_file="$1"

# Check if input file is provided and exists
if [ -z "$input_file" ]; then
  echo "Error: No input wordlist provided."
  echo "Usage: $0 <input_wordlist>"
  exit 1
fi

# Ensure work_path exists
mkdir -p "$work_path"

# Start time (in seconds)
start_time=$(date +%s)

# Step 1: Run expander on the input wordlist
echo "Running expander on the input wordlist..."

# Generate intermediate wordlist (cand.exp)
$hu_path/expander.bin < "$input_file" | sort -u > "$work_path/cand.exp"

# Step 2: Append the expanded results to the input wordlist
echo "Appending expanded words to the intermediate wordlist..."

cat "$work_path/cand.exp" >> "$input_file"

# Step 3: Find the maximum line length in the entire input file
echo "Determining the longest line in the input file..."

max_length=$(awk '{ if (length > max) max = length } END { print max }' "$input_file")

# Cap max_length at 16 characters (since that's the maximum we care about)
if [ "$max_length" -gt 16 ]; then
  max_length=16
fi

echo "Detected max line length: $max_length"
echo "Processing cuts up to a maximum of $max_length characters..."

# Step 4: Perform the cut operations on the input file

# Cut the first half of the string (up to max_length)
for i in $(seq 1 $(($max_length / 2))); do
  $hu_path/cutb.bin 0 $i < "$input_file" | sort -u >> "$work_path/cand.cutb"
done

# Cut the last half of the string (up to max_length)
for i in $(seq 1 $(($max_length / 2))); do
  $hu_path/cutb.bin -$i < "$input_file" | sort -u >> "$work_path/cand.cutb"
done

# For odd-length strings, handle the middle character
if [ $(($max_length % 2)) -eq 1 ]; then
  middle_index=$(($max_length / 2 + 1))
  $hu_path/cutb.bin 0 $middle_index < "$input_file" | sort -u >> "$work_path/cand.cutb"
fi

# Step 5: Final sort and unique to produce the result
sort -u "$work_path/cand.cutb" -o "$work_path/cand.cutb"

# End time (in seconds)
end_time=$(date +%s)

# Calculate the runtime in seconds
runtime=$((end_time - start_time))

# Convert runtime to human-readable format (HH:MM:SS)
hours=$((runtime / 3600))
minutes=$(((runtime % 3600) / 60))
seconds=$((runtime % 60))

# Output the runtime
echo "Processing complete!"
printf "Total runtime: %02d:%02d:%02d\n" $hours $minutes $seconds

