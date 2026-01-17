echo -e "${GREEN}[*] Launching dashboard...${NC}"
            source /etc/os-release
        os_name=$PRETTY_NAME 

        IP=$(hostname -I | awk '{print $1}')
        KERNEL=$(uname -r)
        UPTIME=$(uptime -p)
        MEMORY=$(free -h | awk '/Mem:/ {print $3 " / " $2}')
        DISK=$(df -h / | awk 'NR==2 {print $3 " / " $2 " (" $5 " used)"}')
        DATE_NOW=$(date "+%Y-%m-%d %H:%M")

        echo -e "${CYAN}-------------------------------------${NC}"
        echo -e "${GREEN} SYSTEM DASHBOARD - $DATE_NOW ${NC}"
        echo -e "${CYAN}-------------------------------------${NC}"
        echo "OS:       $os_name"
        echo "Kernel:   $KERNEL"    
        echo "Hostname: $(hostname)"
        echo -e "${CYAN}-------------------------------------${NC}"
        echo "IP Address:  $IP"
        echo "Uptime:      $UPTIME"
        echo -e "${CYAN}-------------------------------------${NC}"
        echo "RAM Usage:   $MEMORY"
        echo "Disk Usage:  $DISK"
        echo -e "${CYAN}-------------------------------------${NC}"
        echo -e "${GREEN}WHO IS ONLINE:${NC}"
        who 
        echo -e "${CYAN}-------------------------------------${NC}"    
    sleep 2