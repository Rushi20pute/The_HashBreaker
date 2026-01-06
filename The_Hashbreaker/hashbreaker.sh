#!/bin/bash

# ===============================
# HashBreaker Framework
# Main Controller
# ===============================

# ---- TERMINAL FIX (BACKSPACE ISSUE SOLVED) ----
#stty sane
#stty erase ^?
#trap "stty sane; echo; exit" INT TERM
stty sane
stty erase '^H'
stty erase '^?'
trap "stty sane" EXIT
bind 'set enable-bracketed-paste off' 2>/dev/null
# ---- COLORS ----
BLUE='\033[1;34m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m'

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"

# ---- MAIN BANNER ----
banner() {
    clear
    echo -e "${BLUE}"
    echo "██╗  ██╗ █████╗ ███████╗██╗  ██╗██████╗ ██████╗ ███████╗ █████╗ ██╗  ██╗███████╗██████╗"
    echo "██║  ██║██╔══██╗██╔════╝██║  ██║██╔══██╗██╔══██╗██╔════╝██╔══██╗██║ ██╔╝██╔════╝██╔══██╗"
    echo "███████║███████║███████╗███████║██████╔╝██████╔╝█████╗  ███████║█████╔╝ █████╗  ██████╔╝"
    echo "██╔══██║██╔══██║╚════██║██╔══██║██╔══██╗██╔══██╗██╔══╝  ██╔══██║██╔═██╗ ██╔══╝  ██╔══██╗"
    echo "██║  ██║██║  ██║███████║██║  ██║██████╔╝██║  ██║███████╗██║  ██║██║  ██╗███████╗██║  ██║"
    echo "╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝"
    echo -e "${NC}"
    echo -e "${CYAN}                            An Offline Hash Cracking Framework${NC}"
    echo -e "${YELLOW}                                    Made by Rushi20Pute${NC}"
    echo "========================================================================================="
    echo
    echo -e "${GREEN}[+] Supported Hashes:${NC}"
    echo "MD5 | SHA1 | SHA224 | SHA256 | SHA384 | SHA512 | NTLM"
    echo 
    echo -e "${YELLOW}[!] Note:${NC} 32-character hashes are automatically tested as ${GREEN}MD5${NC} and ${GREEN}NTLM${NC}"
    echo
}

menu() {
    echo -e "${GREEN}1) Crack Hash${NC}"
    echo -e "${GREEN}2) Generate Hash${NC}"
    echo -e "${GREEN}3) Decoder${NC}"
    echo -e "${GREEN}4) Encoder${NC}"
    echo -e "${RED}0) Exit${NC}"
    echo
}

# ---- MAIN LOOP ----
while true; do
    banner
    menu
    stty sane
    stty erase '^H'
    stty erase '^?'
    IFS= read -e -p "Select an option: " choice

    case "$choice" in
        1)
            exec bash "$BASE_DIR/core/cracker.sh"
            ;;
        2)
            exec bash "$BASE_DIR/core/generator.sh"
            ;;
        3)
            exec bash "$BASE_DIR/utils/decoder.sh"
            ;;
        4)
            exec bash "$BASE_DIR/utils/encoder.sh"
            ;;
        0)
            echo
            echo -e "${YELLOW}Exiting HashBreaker Framework...${NC}"
            sleep 1
            clear
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid option! Try again.${NC}"
            sleep 1
            ;;
    esac
done
