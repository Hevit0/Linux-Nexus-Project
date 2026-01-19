# Nexus Admin Console V1.0
**The Commander - A Modular Bash-Based DevSecOps Toolkit**

![Nexus Banner](https://img.shields.io/badge/Version-1.0-cyan.svg)
![Platform](https://img.shields.io/badge/Platform-Linux%20%7C%20Debian-lightgrey.svg)
![Language](https://img.shields.io/badge/Language-Bash%20Scripting-green.svg)

## Overview
**Nexus Admin Console** is a modular system designed for Linux administrators and security enthusiasts. Developed during my first year at **POLITEHNICA Bucharest (FILS)**, this project bridges the gap between simple scripting and automated system architecture. 

It's not just a script; it's a foundation for **DevSecOps** automation.

---

## Key Features & Modules

### 1. Breach Detector
Analyzes authentication logs (`auth.log`) to identify brute-force attempts. 
- **Tech:** Uses `grep`, `awk`, and `uniq` to count and sort suspicious IP addresses.
- **Goal:** Incident response and threat identification.

### 2. Web Sentry (Live Monitoring)
Real-time connectivity auditor for critical web services.
- **Tech:** Uses `curl` with specific HTTP response code mapping.
- **Goal:** Uptime monitoring and network troubleshooting.

### 3. Smart Backup & Cleanup
Automated archival system with built-in intelligence.
- **Tech:** Integrity checks, `df`/`du` space verification, and `tar` compression.
- **Feature:** Auto-cleanup logic for archives older than 7 days to prevent disk bloat.

### 4. System Dashboard
A high-level diagnostic tool for real-time monitoring.
- **Displays:** Kernel version, IP Address, Uptime, RAM/Disk usage, and active users.

### 5. User & Permission Management
Automates organizational workspace setup.
- **Logic:** Processes `.csv` datasets to create hierarchical directories and unique security keys based on roles (Admin vs Intern).

---

## Architecture
Nexus uses a **Modular Core** design:
```text
.
├── nexus.sh             # Main entry point (The Orchestrator)
├── modules/
│   ├── system_dashboard.sh
│   ├── web_sentry.sh
│   ├── breach_detector.sh
│   ├── smart_backup.sh
│   ├── user_mgmt.sh
│   └── permission_mgmt.sh
└── nexus_history.log    # Centralized logging system
```
## Architecture
-A Linux-based environment(Debian/Ubuntu)
-Permissions to execute scripts.

## Installation & Usage
1. **Clone the repository** (this creates a folder named 'linux-nexus-project'):
```bash
git clone [[https://github.com/Hevit0/nexus-admin-console.git](https://github.com/Hevit0/nexus-admin-console.git)]
```
2.**Navigate to the project:**
```bash
cd linux-nexus-project
```
3.**Make the orchestrator executale**(if needed):
```bash
chmod +x nexus.sh
```

4.**Run the orchestrator:**
```bash
./nexus.sh
```
**Roadmap** (V2.0)
[ ] Asynchronous Scanning: Integrating background processes for network audits.

[ ] Telegram/Slack Integration: Real-time alerts for breach detections.

[ ] Dockerization: Wrapping the environment for portable deployment.

👨‍💻 Author
Neacsu Andrei Sebastian First-year Student at POLITEHNICA Bucharest (FILS CTI)

[Linkedin](https://www.linkedin.com/in/andrei-sebastian-neacsu/)

Email:andreisebastian11@gmail.com

"Don't wait for a degree to start building systems. Build the system that earns you the degree."

