#!/bin/bash

echo "Welcome to the Pen Name Generator!"

# URLs to external files containing male and female first names, and last names
maleFirstNamesURL="https://example.com/male_first_names.txt"
femaleFirstNamesURL="https://raw.githubusercontent.com/chameleonhash/bash-scripts/main/female.txt"
lastNamesURL="https://example.com/last_names.txt"

# Function to download names from a URL into an array
function downloadNamesFromURL {
    url=$1
    IFS=$'\n' read -d '' -r -a names < <(curl -s "$url")
}

# Download names from external URLs
downloadNamesFromURL "$maleFirstNamesURL"
maleFirstNames=("${names[@]}")

downloadNamesFromURL "$femaleFirstNamesURL"
femaleFirstNames=("${names[@]}")

downloadNamesFromURL "$lastNamesURL"
lastNames=("${names[@]}")

# Function to generate a random element from an array
function getRandomElement {
    array=("$@")
    length=${#array[@]}
    index=$((RANDOM % length))
    echo "${array[index]}"
}

# Ask the user to choose gender for the first name
read -p "Do you want a male or female first name? (Type 'male' or 'female'): " userGender

# Validate user input
if [[ "$userGender" == "male" ]]; then
    firstNames=("${maleFirstNames[@]}")
elif [[ "$userGender" == "female" ]]; then
    firstNames=("${femaleFirstNames[@]}")
else
    echo "Invalid input. Using all first names."
    firstNames=("${maleFirstNames[@]}" "${femaleFirstNames[@]}")
fi

# Ask the user to generate a pen name
read -p "Press Enter to generate your pen name..."

# Generate a pen name
generatedFirstName=$(getRandomElement "${firstNames[@]}")
generatedLastName=$(getRandomElement "${lastNames[@]}")

# Print the generated pen name
echo "Your pen name is: $generatedFirstName $generatedLastName"
