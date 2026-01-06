#!/bin/bash

# ===============================
# HASH GENERATOR MODULE
# Part of HashBreaker Framework
# ===============================

# ---- TERMINAL FIX ----
stty sane
stty erase ^?
trap "stty sane; echo; exit" INT TERM

# ---- COLORS ----
BLUE='\033[1;34m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m'

# ---- BANNER ----
banner() {
    clear
    echo -e "${GREEN}"
    echo " ██████╗ ███████╗███╗   ██╗███████╗██████╗  █████╗ ████████╗ ██████╗ ██████╗"
    echo "██╔════╝ ██╔════╝████╗  ██║██╔════╝██╔══██╗██╔══██╗╚══██╔══╝██╔═══██╗██╔══██╗"
    echo "██║  ███╗█████╗  ██╔██╗ ██║█████╗  ██████╔╝███████║   ██║   ██║   ██║██████╔╝"
    echo "██║   ██║██╔══╝  ██║╚██╗██║██╔══╝  ██╔══██╗██╔══██║   ██║   ██║   ██║██╔══██╗"
    echo "╚██████╔╝███████╗██║ ╚████║███████╗██║  ██║██║  ██║   ██║   ╚██████╔╝██║  ██║"
    echo " ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝"
    echo -e "${NC}"
    echo -e "${CYAN}                    Offline Hash Generator${NC}"
    echo -e "${YELLOW}                        Made by Rushi${NC}"
    echo "============================================================================"
    echo
}

# ---- MAIN ----
banner

echo -e "${GREEN}[+] Supported Hashes:${NC}"
echo "MD5 | SHA1 | SHA224 | SHA256 | SHA384 | SHA512 | NTLM"
echo

read -erp "Enter text to hash: " INPUT
echo
echo -e "${BLUE}╔══════════════════════════════════════╗${NC}"
echo -e "${BLUE}║        ${CYAN}SELECT HASH ALGORITHM		${BLUE}║${NC}"
echo -e "${BLUE}╠══════════════════════════════════════╣${NC}"
echo -e "${BLUE}║${NC} ${GREEN}[1]${NC} MD5                              ${BLUE}║${NC}"
echo -e "${BLUE}║${NC} ${GREEN}[2]${NC} SHA1                             ${BLUE}║${NC}"
echo -e "${BLUE}║${NC} ${GREEN}[3]${NC} SHA224                           ${BLUE}║${NC}"
echo -e "${BLUE}║${NC} ${GREEN}[4]${NC} SHA256                           ${BLUE}║${NC}"
echo -e "${BLUE}║${NC} ${GREEN}[5]${NC} SHA384                           ${BLUE}║${NC}"
echo -e "${BLUE}║${NC} ${GREEN}[6]${NC} SHA512                           ${BLUE}║${NC}"
echo -e "${BLUE}║${NC} ${GREEN}[7]${NC} NTLM (Windows Hash)              ${BLUE}║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════╝${NC}"
echo
#echo "Choose hash type:"
#echo "1) MD5"
#echo "2) SHA1"
#echo "3) SHA224"
#echo "4) SHA256"
#echo "5) SHA384"
#echo "6) SHA512"
#echo "7) NTLM"
#echo

read -erp "$(echo -e "${CYAN}➜ Select hash option:${NC} ")" opt
#read -erp "Select option: " opt
echo

case "$opt" in
    1) HASH=$(echo -n "$INPUT" | md5sum | awk '{print $1}') ;;
    2) HASH=$(echo -n "$INPUT" | sha1sum | awk '{print $1}') ;;
    3) HASH=$(echo -n "$INPUT" | sha224sum | awk '{print $1}') ;;
    4) HASH=$(echo -n "$INPUT" | sha256sum | awk '{print $1}') ;;
    5) HASH=$(echo -n "$INPUT" | sha384sum | awk '{print $1}') ;;
    6) HASH=$(echo -n "$INPUT" | sha512sum | awk '{print $1}') ;;
    #7) HASH=$(echo -n "$INPUT" | iconv -t utf16le | md4sum | awk '{print $1}') ;;
    7)HASH=$(echo -n "$INPUT" | iconv -t utf16le | openssl md4 | awk '{print $2}') ;;
    *) echo -e "${RED}Invalid option${NC}"; exit 1 ;;
esac

echo -e "${GREEN}[✔] Generated Hash:${NC}"
echo -e "${CYAN}$HASH${NC}"
echo
