#!/bin/bash
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
CYAN='\033[36m'
NC='\033[0m'

WEBSITES=(
    "https://google.com"
    "https://github.com"
    "https://linkedin.com"
    "https://upb.ro"
    "https://nonexistent.website"
)

echo -e "${CYAN}==========================================${NC}"
echo -e "${CYAN}   🚀 WEB SENTRY - LIVE MONITORING   ${NC}"
echo -e "${CYAN}==========================================${NC}"
printf "%-35s %-10s %-10s\n" "WEBSITE" "STATUS" "TIME"
echo "--------------------------------------------------------"

for site in "${WEBSITES[@]}"; do

    RESPONSE=$(curl -s -o /dev/null -w "%{http_code} %{time_total}" -m 3 "$site")

    HTTP_CODE=$(echo "$RESPONSE" | awk '{print $1}')
    TIME=$(echo "$RESPONSE" | awk '{print $2}')

    if [[ "$HTTP_CODE" == "200" ]]; then
        STATUS_COLOR=$GREEN
    elif [[ "$HTTP_CODE" == "301" || "$HTTP_CODE" == "302" ]]; then
        STATUS_COLOR=$YELLOW
        HTTP_CODE="REDIRECT"
    elif [[ "$HTTP_CODE" == "404" || "$HTTP_CODE" == "500" || "$HTTP_CODE" == "000" ]]; then
        STATUS_COLOR=$RED
        if [[ "$HTTP_CODE" == "000" ]]; then HTTP_CODE="DOWN"; fi
    else
        STATUS_COLOR=$YELLOW
    fi

    printf "%-35s ${STATUS_COLOR}%-10s${NC} ${CYAN}%-10s${NC}\n" "$site" "$HTTP_CODE" "${TIME}s"
done