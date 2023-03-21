#!/bin/bash


RED='\033[0;31m'
GREEN='\033[1;32m'
WHITE='\033[1;37m'
YELLOW='\033[1;33m'



# Check for text file argument
if [ $# -ne 1 ]; then
    printf "\n${YELLOW}[i]  Usage: $0 <file.txt> \n"
    exit 1
fi

# Store text file argument as variable
file=$1

# Loop through each line in text file
while read -r endpoint; do
    # Extract JavaScript files
    js_files=$(curl -Ls $endpoint | grep -oE "(http|https)://[a-zA-Z0-9./?=_-]*\.js")

    # Loop through each JavaScript file
    for js_file in $js_files; do
        # Check for sensitive information
        leaks=$(curl -Ls $js_file | grep -oEi "(password|token|api|hidden|secret|apikey|key|credentials|admin|MySQL|aws|OTP|oauth|config|DATABASE|\.bak|\.sql|\.old|\.txt|\.cnf|\.ini|\.save|\.swp|bucket|db_|firebase|@yopmail|@coffeetimer24|@chotunai|internal|backup|\.env|\.json|\.git|id_dsa|\.yaml|\.cfg)" | awk '{print "\n [+] The Word is : " $0}')

        # Output results
        if [ -n "$leaks" ]; then
            printf "\n${WHITE} [+] This Endpoint $js_file has The following match \n ";
            printf "${GREEN}$leaks" | sort -u ;
            printf "\n";
        else
            printf "\n${RED} [-] No Result Found! \n";
        fi
    done
done < "$file"
