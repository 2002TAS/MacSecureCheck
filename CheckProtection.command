#!/bin/bash

# ANSI colors
GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[0;33m"
RESET="\033[0m"

# Clear the screen
clear

echo "----------------------------------------"
echo "          macOS Protection Status"
echo "----------------------------------------"
echo ""

# SIP
echo "System Integrity Protection (SIP):"
sip=$(csrutil status 2>/dev/null)
if echo "$sip" | grep -qi "enabled"; then
  echo -e "${GREEN}${sip}${RESET}"
else
  echo -e "${RED}${sip}${RESET}"
fi
echo ""

# Gatekeeper
echo "Gatekeeper:"
gatekeeper=$(spctl --status 2>/dev/null)
if echo "$gatekeeper" | grep -qi "enabled"; then
  echo -e "${GREEN}${gatekeeper}${RESET}"
else
  echo -e "${RED}${gatekeeper}${RESET}"
fi
echo ""

# XProtect
echo "XProtect Version:"
xprotectVersion=$(defaults read /System/Library/CoreServices/XProtect.bundle/Contents/Info.plist CFBundleShortVersionString 2>/dev/null)
if [ -n "$xprotectVersion" ]; then
  echo -e "${GREEN}XProtect version: $xprotectVersion${RESET}"
else
  echo -e "${RED}XProtect version: Unknown${RESET}"
fi
echo ""

# Firewall
echo "Firewall:"
firewallStatus=$(defaults read /Library/Preferences/com.apple.alf globalstate 2>/dev/null)
if [ "$firewallStatus" == "1" ]; then
  echo -e "${GREEN}Firewall is enabled.${RESET}"
else
  echo -e "${RED}Firewall is disabled.${RESET}"
fi
echo ""

# FileVault
echo "FileVault:"
fileVaultStatus=$(fdesetup status 2>/dev/null)
if echo "$fileVaultStatus" | grep -qi "On"; then
  echo -e "${GREEN}${fileVaultStatus}${RESET}"
else
  echo -e "${RED}${fileVaultStatus}${RESET}"
fi
echo ""

# Secure Boot & T2/Apple Silicon
echo "Secure Boot & T2/Apple Silicon Status:"
t2chip=$(system_profiler SPiBridgeDataType | grep "Model Name" | awk -F': ' '{print $2}')
secureBoot=$(system_profiler SPiBridgeDataType | grep "Secure Boot" | awk -F': ' '{print $2}')
if [ -n "$t2chip" ]; then
  echo -e "T2 Chip: ${GREEN}$t2chip${RESET}"
else
  echo -e "Apple Silicon Secure Enclave: ${YELLOW}Detected${RESET}"
fi
if [ -n "$secureBoot" ]; then
  echo -e "Secure Boot: ${GREEN}$secureBoot${RESET}"
else
  echo -e "Secure Boot: ${RED}Not Available${RESET}"
fi
echo ""

# macOS version
echo "macOS Version:"
version=$(sw_vers | awk '/ProductVersion/ {print $2}')
echo -e "${YELLOW}$version${RESET}"
echo ""

# Uptime
echo "System Uptime:"
uptimeSec=$(sysctl -n kern.boottime | awk -F'[, ]+' '{print $4}')
currentSec=$(date +%s)
uptime=$(( (currentSec - uptimeSec) / 60 ))
hours=$(( uptime / 60 ))
minutes=$(( uptime % 60 ))
echo -e "${YELLOW}Uptime: $hours hours, $minutes minutes${RESET}"
echo ""

# Battery Health
echo "Battery Health:"
cycleCount=$(system_profiler SPPowerDataType | grep "Cycle Count" | awk '{print $3}')
condition=$(system_profiler SPPowerDataType | grep "Condition" | awk '{print $2}')
if [ -n "$cycleCount" ]; then
  echo -e "Cycle Count: ${YELLOW}$cycleCount${RESET}"
else
  echo -e "Cycle Count: ${RED}Not Available${RESET}"
fi
if [ -n "$condition" ]; then
  echo -e "Condition: ${YELLOW}$condition${RESET}"
else
  echo -e "Condition: ${RED}Not Available${RESET}"
fi
echo ""

# Disk Space
echo "Disk Space:"
disk=$(df -h / | awk 'NR==2 {print "Used: "$3" / Total: "$2" (Available: "$4")"}')
echo -e "${YELLOW}${disk}${RESET}"
echo ""

# Recent Security Updates
echo "Recent Security Updates (last 30 days):"
updates=$(softwareupdate --history | grep -i "Security" | grep -i "202" | tail -n 5)
if [ -n "$updates" ]; then
  echo -e "${YELLOW}$updates${RESET}"
else
  echo -e "${RED}No recent security updates found.${RESET}"
fi
echo ""

# macOS Software Update Status
echo "macOS Software Update Status:"
updates=$(softwareupdate -l 2>/dev/null | grep -E "Label:" | awk -F': ' '{print $2}')
if [ -n "$updates" ]; then
  echo -e "${YELLOW}$updates${RESET}"
else
  echo -e "${GREEN}No updates available.${RESET}"
fi
echo ""

echo "----------------------------------------"
echo "Protection Status Check Complete"
echo "----------------------------------------"
