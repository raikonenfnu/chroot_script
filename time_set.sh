#!/bin/bash

# Retrieve the JSON data from the URL
echo "Retrieving UTC time information"
json_data=$(curl -s "http://worldtimeapi.org/api/timezone/UTC")

# Extract the "utc_datetime" attribute value from the JSON data
utc_datetime=$(echo "$json_data" | grep -o '"utc_datetime":"[^"]*' | cut -d '"' -f 4)

# Format the date string to MMDDHHNNYYYY format
formatted_date=$(date -d "$utc_datetime" +"%m%d%H%M%Y")

# Set the system date using the formatted date string
date "$formatted_date"

