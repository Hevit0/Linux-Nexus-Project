#!/bin/bash
GREEN='\e[32m'
RED='\e[31m'
YELLOW='\e[33m'
NC='\e[0m'

if [ $# -ne 2 ]; then
    echo -e "${RED}[ERROR] Usage: $0 <source_directory> <backup_directory>${NC}"
    exit 1
fi

SOURCE_DIR="$1"
BACKUP_DIR="$2"

if [ ! -d "$SOURCE_DIR" ]; then
    echo -e "${RED}[ERROR] Source directory '$SOURCE_DIR' does not exist.${NC}"
    exit 1
fi

if [ ! -d "$BACKUP_DIR" ]; then
    echo -e "${YELLOW}[INFO] Creating backup directory '$BACKUP_DIR'...${NC}"
    mkdir -p "$BACKUP_DIR"
fi

NECESSARY_SPACE=$(du -s "$SOURCE_DIR" | awk '{print $1}')
AVAILABLE_SPACE=$(df --output=avail "$BACKUP_DIR" | tail -1 )

if [ "$AVAILABLE_SPACE" -lt "$NECESSARY_SPACE" ]; then
    echo -e "${RED}[ERROR] Insufficient space in backup directory.${NC}"
    echo -e "${YELLOW}Required: $NECESSARY_SPACE KB, Available: $AVAILABLE_SPACE KB${NC}"
    exit 1
fi

DIR_NAME=$(basename "$SOURCE_DIR")
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_NAME="backup_${DIR_NAME}_${TIMESTAMP}.tar.gz"
FULL_PATH="$BACKUP_DIR/$BACKUP_NAME"

echo -e "${GREEN}[*] Starting backup of '$SOURCE_DIR'...${NC}"

tar -czf "$FULL_PATH" -C "$SOURCE_DIR" . 2>/dev/null

TAR_EXIT_CODE=$?

if [ $TAR_EXIT_CODE -eq 0 ]; then
        SIZE=$(du -h "$BACKUP_DIR/$BACKUP_NAME" | cut -f1)
        echo -e "${GREEN}[SUCCESS] Backup created: $BACKUP_NAME ($SIZE)${NC}"
    elif [ $TAR_EXIT_CODE -eq 1 ]; then
        echo -e "${RED}[MINOR ERROR] The archive could've been created, but some files were modified during the backup process.${NC}"
        sleep 1
        echo -e "${YELLOW}Please verify the backup integrity.${NC}"
        sleep 1 
        echo -e "${YELLOW}Be sure no one is working on the files while performing backup.${NC}"
        exit 1
    elif [ $TAR_EXIT_CODE -eq 2 ]; then
        echo -e "${RED}[FATAL ERROR]The archive was not created or it is corrupted/incomplete.${NC}"
        sleep 1
        echo -e "${YELLOW}Possible causes:${NC}"
        echo -e "${YELLOW} - Insufficient disk space.${NC}"
        echo -e "${YELLOW} - Lack of write permissions in the destination.${NC}"
        echo -e "${YELLOW} - Source files don't exist. ${NC}"
        echo -e "${YELLOW} - Wrong syntax.${NC}"
        sleep 1
        echo -e "${YELLOW} Try \"df -h\" to check available disk space.${NC}"
        sleep 2
        if [ -f "$FULL_PATH" ]; then rm "$FULL_PATH"; fi
        exit 2
    elif [ $TAR_EXIT_CODE -eq 126 ]; then
        echo -e "${RED}[NO PERMISSIONS] Found \"tar\" command but no permission to execute it.${NC}"
        echo -e "${YELLOW} Run with elevated permissions or check the tar installation.${NC}"
        exit 126
    elif [ $TAR_EXIT_CODE -eq 127 ]; then
        echo -e "${RED}[COMMAND NOT FOUND] The system does not regonize the \"tar\" command.${NC}"
        echo -e "${YELLOW} Install with \"sudo apt install tar\" and try again.${NC}"
        exit 127
    else
        echo -e "${RED}[UNKNOWN ERROR] Something went wrong during compression.${NC}"
        exit $TAR_EXIT_CODE
    fi

echo "Checking for backups older than 7 days..."
find "$BACKUP_DIR" -type f -name "backup_${DIR_NAME}_*.tar.gz" -mtime +7 -exec rm {} \;
echo -e "${GREEN}Cleanup complete. System secured.${NC}"

exit 0