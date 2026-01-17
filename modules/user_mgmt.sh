#!/bin/bash
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${CYAN}==============================================${NC}"
echo -e "${CYAN}                 User Management              ${NC}"
echo -e "${CYAN}==============================================${NC}"

FILE="$1"

if [ ! -f "$FILE" ]; then
    echo -e "${RED}[ERROR] File not found: $FILE${NC}"
    exit 1
fi

 TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

while IFS=',' read -r name department role; do  

    role=$(echo "$role" | tr -d '\r')

    echo "Name : "$name" , Dep: "$department" , Role: "$role""

    DIR_NAME="workspace/$department/$name"
    mkdir -p "$DIR_NAME"

RANDOM_NUMBER=$((RANDOM % 100 + 1))

    if [ "$role" == "Admin" ] || [ "$role" == "admin" ]; then
        echo "Creating key for admin!"
        echo "$TIMESTAMP : "$name" : $RANDOM_NUMBER" > "$DIR_NAME/admin_key.txt"
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}[SUCCESS] Key generated for Admin "$name" ${NC}"
        else
            echo -e "${RED}[ERROR] Failed to create key for Admin "$name"${NC}"
        fi
    fi

    if [ "$role" == "User" ] || [ "$role" == "Intern" ] || [ "$role" == "user" ] || [ "$role" == "intern" ]; then
        echo "Creating welcome message for user/intern!"
        echo "Welcome "$name" to the "$department" team!" > "$DIR_NAME/welcome.txt"
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}[SUCCESS] Welcome message created for "$name" ${NC}"
        else
            echo -e "${RED}[ERROR] Failed to create welcome message for "$name"${NC}"
        fi
    fi
done < "$FILE"