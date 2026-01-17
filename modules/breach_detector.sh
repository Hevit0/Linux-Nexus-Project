    RED='\e[31m'
    GREEN='\e[32m'
    NC='\e[0m' 

    LOG_FILE="$1"

    if [ ! -f "$LOG_FILE" ]; then
            echo -e "${RED}[ERROR] Log file '$LOG_FILE' does not exist.${NC}"
            sleep 3
            exit 2
    fi

        command=$(grep "Failed password" "$LOG_FILE" | awk '{print $(NF-3)}' | sort | uniq -c | sort -nr)
    if [ -z "$command" ]; then
            sleep 1
            exit 1
    else
            echo -e "${GREEN}Analyzing log file: $LOG_FILE...${NC}"
            sleep 1
            echo "---------------------------------------------------" 
            echo -e "${RED}SUSPECTS IDENTIFIED ( Attempts - IP Address )${NC}"
            echo "---------------------------------------------------" 

            echo "$command"

            sleep 1
            echo -e "${NC}\nAnalysis complete."
    fi