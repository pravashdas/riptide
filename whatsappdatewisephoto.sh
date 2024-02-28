#!/bin/bash

# Define the download location
DOWNLOAD_LOCATION="$HOME/Downloads"

# Define the destination directory
DESTINATION_DIR="$HOME/whatsapp_photo"

# Create destination directory if it doesn't exist
mkdir -p "$DESTINATION_DIR"

# Get list of unique dates from file names
DATES=$(find "$DOWNLOAD_LOCATION" -type f -name "WhatsApp Image*" -exec basename {} \; | sed -E 's/WhatsApp Image ([0-9]{4}-[0-9]{2}-[0-9]{2}).*/\1/' | sort | uniq)

# Loop through each unique date
for DATE in $DATES; do
    # Create date-wise subdirectory if it doesn't exist
    mkdir -p "$DESTINATION_DIR/$DATE"

    # Move files from download location to whatsapp_photo with date-wise subdirectory
    for file in "$DOWNLOAD_LOCATION/"*"WhatsApp Image $DATE"*; do
        mv "$file" "$DESTINATION_DIR/$DATE"
    done

    # Print message for each date
    if [ $? -eq 0 ]; then
        echo "Files for $DATE moved successfully to $DESTINATION_DIR/$DATE"
    else
        echo "No files found for $DATE to move."
    fi
done
