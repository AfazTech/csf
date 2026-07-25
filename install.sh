#!/bin/bash
###############################################################################
# CSF Simple Installer - AfazTech Fork
# Usage: bash <(curl -s https://raw.githubusercontent.com/AfazTech/csf/main/install.sh)
###############################################################################

set -e

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  CSF Firewall Installer (AfazTech)${NC}"
echo -e "${GREEN}========================================${NC}"
echo

# Check root
if [ "$(id -u)" != "0" ]; then
    echo -e "${RED}Error: This script must be run as root${NC}"
    exit 1
fi

# Working directory
WORK_DIR="/usr/src"
cd "$WORK_DIR" || exit 1

# Clean previous
echo "[+] Cleaning previous downloads..."
rm -rf csf* AfazTech-csf* 2>/dev/null || true

# Download
echo "[+] Downloading CSF from GitHub..."
if command -v wget >/dev/null 2>&1; then
    wget -q --show-progress -O csf.tar.gz https://github.com/AfazTech/csf/archive/refs/heads/main.tar.gz
elif command -v curl >/dev/null 2>&1; then
    curl -L -o csf.tar.gz https://github.com/AfazTech/csf/archive/refs/heads/main.tar.gz
else
    echo -e "${RED}Error: wget or curl is required${NC}"
    exit 1
fi

# Extract
echo "[+] Extracting..."
tar -xzf csf.tar.gz
cd AfazTech-csf-main || cd csf-main || {
    echo -e "${RED}Error: Could not find extracted directory${NC}"
    exit 1
}

# Run original installer
echo "[+] Starting installation..."
echo

if [ -e "/usr/local/cpanel/version" ]; then
    echo "Detected: cPanel"
    sh install.cpanel.sh
elif [ -e "/usr/local/directadmin/directadmin" ]; then
    echo "Detected: DirectAdmin"
    sh install.directadmin.sh
elif [ -e "/usr/local/interworx" ]; then
    echo "Detected: InterWorx"
    sh install.interworx.sh
elif [ -e "/usr/local/cwpsrv" ]; then
    echo "Detected: CentOS Web Panel"
    sh install.cwp.sh
elif [ -e "/usr/local/vesta" ]; then
    echo "Detected: VestaCP"
    sh install.vesta.sh
elif [ -e "/usr/local/CyberCP" ]; then
    echo "Detected: CyberPanel"
    sh install.cyberpanel.sh
else
    echo "Detected: Generic Linux"
    sh install.generic.sh
fi

# Cleanup
cd "$WORK_DIR"
rm -rf csf.tar.gz AfazTech-csf-main csf-main 2>/dev/null || true

echo
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  Installation completed!${NC}"
echo -e "${GREEN}========================================${NC}"
echo
echo "Recommended next steps:"
echo "  1. csf -v                  # Check version"
echo "  2. perl /usr/local/csf/bin/csftest.pl"
echo "  3. Disable AUTO_UPDATES:"
echo "     sed -i 's/AUTO_UPDATES = \"1\"/AUTO_UPDATES = \"0\"/' /etc/csf/csf.conf"
echo "     csf -r"
echo