#!/bin/bash
stty sane
stty erase '^?'
BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
# =========================================
# ENCODER Utility
# Hashbreaker Framework by rushi20pute
# =========================================

# -------- Colors --------
BLUE='\033[1;34m'
CYAN='\033[1;36m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
NC='\033[0m'

# -------- Banner --------
banner() {
    clear
    echo -e "${CYAN}"
    echo " ███████╗███╗   ██╗ ██████╗ ██████╗ ██████╗ ███████╗██████╗ "
    echo " ██╔════╝████╗  ██║██╔════╝██╔═══██╗██╔══██╗██╔════╝██╔══██╗"
    echo " █████╗  ██╔██╗ ██║██║     ██║   ██║██║  ██║█████╗  ██████╔╝"
    echo " ██╔══╝  ██║╚██╗██║██║     ██║   ██║██║  ██║██╔══╝  ██╔══██╗"
    echo " ███████╗██║ ╚████║╚██████╗╚██████╔╝██████╔╝███████╗██║  ██║"
    echo " ╚══════╝╚═╝  ╚═══╝ ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝"
    echo -e "${YELLOW}        Hashbreaker Framework by rushi20pute${NC}"
    echo -e "${GREEN}                ENCODER MODULE${NC}"
    echo
}

pause() {
    read -rp "Press Enter to continue..."
}

menu() {
    echo -e "${BLUE}--- ENCODER MENU ---${NC}"
    echo "1) Base64 Encode"
    echo "2) Base32 Encode"
    echo "3) Hex Encode"
    echo "4) URL Encode"
    echo "5) ROT13 Encode"
    echo "6) Binary Encode"
    echo "--------------------------------"
    echo "B) Back to HashBreaker"
    echo "0) Exit"
    echo
    echo -n "Select option: "
}

print_result() {
    echo -e "${GREEN}"
    echo "--------------------------------------"
    echo "Encoded output is:"
    echo "--------------------------------------"
    echo -e "${NC}$1"
    echo
}

# -------- Main --------
banner
while true; do
    menu
    read -r choice

    case "$choice" in
        1)
            echo -n "Enter plain text: "
            read -r t
            res=$(echo -n "$t" | base64)
            print_result "$res"
            pause
            banner
            ;;
        2)
            echo -n "Enter plain text: "
            read -r t
            res=$(echo -n "$t" | base32)
            print_result "$res"
            pause
            banner
            ;;
        3)
            echo -n "Enter plain text: "
            read -r t
            res=$(echo -n "$t" | xxd -p)
            print_result "$res"
            pause
            banner
            ;;
        4)
            echo -n "Enter plain text: "
            read -r t
            # URL encode without external deps
            res=$(python3 - <<'PY'
import sys, urllib.parse
print(urllib.parse.quote(sys.stdin.read(), safe=''))
PY
<<< "$t")
            print_result "$res"
            pause
            banner
            ;;
        5)
            echo -n "Enter plain text: "
            read -r t
            res=$(echo "$t" | tr 'A-Za-z' 'N-ZA-Mn-za-m')
            print_result "$res"
            pause
            banner
            ;;
        6)
            echo -n "Enter plain text: "
            read -r t
            out=""
            for ((i=0; i<${#t}; i++)); do
                printf -v bin "%08d" "$(echo "obase=2; ibase=10; $(printf '%d' "'${t:i:1}")" | bc)"
                out+="$bin "
            done
            print_result "$out"
            pause
            banner
            ;;
        B|b)
            bash "$BASE_DIR/hashbreaker.sh"
            exit 0
            ;;
        0)
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid option${NC}"
            pause
            banner
            ;;
    esac
done
