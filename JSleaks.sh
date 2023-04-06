#!/bin/bash


RED='\033[0;31m'
GREEN='\033[1;32m'
WHITE='\033[1;37m'
YELLOW='\033[1;33m'



# Check for text file argument
if [ $# -ne 2 ]; then
    printf "\n${YELLOW}[i]  Usage: $0  <target.com> <file.txt> \n"
    exit 1
fi

# Store text file argument as variable
file=$2

# Loop through each line in text file
if [ -f $file ]; then
    endpoints=$(cat $file);
    # Extract JavaScript files
    #js_files=$(curl -Ls $endpoint | grep -oE "(http|https)://[a-zA-Z0-9./?=_-]*\.js")
    printf "\n\r${WHITE} JS-Leaks Tool \n";
    printf "\n\r${WHITE} Mohamed Abdelhady \n";
    # Loop through each JavaScript file
    for js_file in $endpoints; do

        if [[ $js_file == *"$1"* ]]; then
                printf "\n${YELLOW}[i] Start Searching in $js_file \n";
        # Check for sensitive information
            leaks=$(curl -Ls $js_file | grep -oEi "(sanity|password|token|api|hidden|secret|apikey|key|credentials|admin|MySQL|aws|OTP|oauth|config|DATABASE|\.bak|\.sql|\.old|\.txt|\.cnf|\.ini|\.save|\.swp|bucket|db_|firebase|@yopmail|@coffeetimer24|@chotunai|internal|backup|\.env|\.json|\.git|id_dsa|\.yaml|\.cfg)" | awk '{print "\n [+] The Word is : " $0}')

        # Output results
            if [ -n "$leaks" ]; then
                printf "\n${WHITE} [+] This Endpoint $js_file has The following match \n ";
                printf "${GREEN}$leaks" | sort -u ;
                printf "\n";
            else
                printf "\n${RED} [-] No Result Found! \n";
            fi
       fi
    done
fi
