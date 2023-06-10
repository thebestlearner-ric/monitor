#!/usr/bin/env bash
FILE="files/website.csv"
RESULTS_FILE="results.log"

timestamp() {
    date "+%Y-%m-%d %H:%M:%S -> $@" >> $RESULTS_FILE
}

init() {

    URL_ARRAY=()
    DOMAIN_ARRAY=()
    RESPONSE_ARRAY=()
}

getURL() {
    local url
    while read -r line
    do
        url=$(echo "$line" | awk -F "," '{print $2}')
        domain_name=$(echo "$line" | awk -F "," '{print $1}')
        URL_ARRAY+=("$url")
        # DOMAIN_ARRAY+=("$domain_name")
    done < "$FILE"
}

probeURL() {
    local result
    local status_code
    for url in "${URL_ARRAY[@]}"; do
        result=$(curl -X GET -s -I --location "$url")
        status_code=$(echo "$result" | awk '/^HTTP/{print $2}')
        RESPONSE_ARRAY+=("$status_code|$url")
    done
      
}


init
getURL
probeURL
# Print the URLs for testing
# for url in "${URL_ARRAY[@]}"; do
#     echo "$url"
# done
# # Print the URLs for testing
# for response in "${RESPONSE_ARRAY[@]}"; do
#     timestamp "$response"
# done
