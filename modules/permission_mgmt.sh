#!/bin/bash
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${CYAN}--- USER PERMISSION AUDIT ---${NC}"

for user_path in /home/*; do
    USER_NAME=$(basename "$user_path")
    
    if [ -d "$user_path" ]; then
        PERMS=$(ls -ld "$user_path" | awk '{print $1}')
        echo -e "User: ${GREEN}$USER_NAME${NC} \t- Perms: ${YELLOW}$PERMS${NC}"
    fi
done

echo -e "${CYAN}-----------------------------${NC}"

while true; do
    echo ""
    echo -e "Enter username to modify (or type 'q' to quit):"
    read SELECTED_USER

    if [ "$SELECTED_USER" == "q" ]; then
        echo -e "${GREEN}Exiting Permission Manager.${NC}"
        break
    fi

    TARGET_DIR="/home/$SELECTED_USER"

    if [ ! -d "$TARGET_DIR" ]; then
        echo -e "${RED}[ERROR] Directory $TARGET_DIR does not exist.${NC}"
        continue
    fi

    CURRENT_PERMS=$(ls -ld "$TARGET_DIR" | awk '{print $1}')
    echo -e "Current permissions for $SELECTED_USER: ${YELLOW}$CURRENT_PERMS${NC}"
    
    echo "Enter new permission code (e.g., 750, 700):"
    read NEW_PERMS

    if [ -z "$NEW_PERMS" ]; then
        echo -e "${RED}[ERROR] Input cannot be empty.${NC}"
        continue
    fi

    chmod "$NEW_PERMS" "$TARGET_DIR"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}[SUCCESS] Permissions updated for $SELECTED_USER to $NEW_PERMS${NC}"
    else
        echo -e "${RED}[ERROR] Failed to update permissions.${NC}"
    fi
done