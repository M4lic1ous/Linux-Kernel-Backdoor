#!/bin/bash

BOLD='\033[1m'
GREEN='\033[1;92m'
BLUE='\033[1;94m'
PURPLE='\033[1;95m'
RESET='\033[0m'

echo -e "${PURPLE}==========================================${RESET}"
echo -e "${BOLD}${BLUE}     Installing Required Packages${RESET}"
echo -e "${PURPLE}==========================================${RESET}"
echo ""

apt-get update
apt-get install -y gcc make build-essential
apt-get install -y netcat-openbsd
apt-get install -y curl wget

echo ""
echo -e "${GREEN}✅ All packages installed successfully!${RESET}"
