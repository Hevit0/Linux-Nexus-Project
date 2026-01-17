CYAN='\e[0;36m'
GREEN='\e[0;32m'
RED='\e[0;31m'
YELLOW='\e[1;33m'
NC='\e[0m' 

show_header() {
    clear
    echo -e "${CYAN}==============================================${NC}"
    echo -e "${CYAN}|            NEXUS ADMIN CONSOLE             |${NC}"
    echo -e "${CYAN}|            V1.0 - The Commander            |${NC}"
    echo -e "${CYAN}==============================================${NC}"
    echo ""
}

show_menu() {
    echo -e "${YELLOW}Select an operation:${NC}"
    echo  "1) System Dashboard"
    echo  "2) Network Checker (Check connectivity)"
    echo  "3) Breach Detector (Analyze logs)"
    echo  "4) Run Backup (Secure files)"
    echo  "5) User Management (Manage users)"
    echo  "6) Permission Management (Manage permissions)"
    echo  "0) Exit Nexus"
    echo -e "${CYAN}----------------------------------------------${NC}"
}

execute_module() {
    local MODULE_PATH="$1"
    shift 

    if [ ! -f "$MODULE_PATH" ]; then
        echo -e "${RED}[ERROR] Module not found at: $MODULE_PATH.${NC}"
        sleep 2
        return 1
    fi

    if [ ! -x "$MODULE_PATH" ]; then
        echo -e "${RED}[INFO] Module '$(basename "$MODULE_PATH")' is not executable.${NC}"
        echo -e "${YELLOW}Setting executable permissions...${NC}"
        chmod +x "$MODULE_PATH" 2>/dev/null
        if [ $? -ne 0 ]; then
            echo -e "${RED}[ERROR] Failed to set executable permissions.${NC}"
            sleep 2
            return 1
        else 
            echo -e "${GREEN}Permissions set successfully.${NC}"
        fi
    fi

    "$MODULE_PATH" "$@"
    
    local EXIT_CODE=$?
    sleep 1
    read -p "Press [Enter] to return to Nexus Menu."
    return $EXIT_CODE
}

while true; do
    show_header
    show_menu

    read -p "Enter your choice [0-6]: " choice
    
    case $choice in
        1) 
            execute_module "./modules/system_dashboard.sh" 
            ;;
        2) 
            execute_module "./modules/web_sentry.sh" 
            ;;
        3) 
            read -p "Enter the log file to analyze for breaches: " LOG_FILE
            execute_module "./modules/breach_detector.sh" "$LOG_FILE" 
            ;;
        4) 
            read -p "Enter source directory: " SRC_DIR
            read -p "Enter destination directory: " BACKUP_DIR
            execute_module "./modules/smart_backup.sh" "$SRC_DIR" "$BACKUP_DIR" 
            ;;
        5) 
            read -p "Enter the path to user data file: " USER_DATA_FILE
            execute_module "./modules/user_mgmt.sh" "$USER_DATA_FILE" 
            ;;
        6) 
            execute_module "./modules/permission_mgmt.sh" 
            ;;
        0) 
            echo -e "${RED}Exiting Nexus Admin Console. Goodbye!${NC}"
            exit 0 
            ;;
        *) 
            echo -e "${RED}Invalid option. Please try again.${NC}"
            sleep 1 
            ;;
    esac
done