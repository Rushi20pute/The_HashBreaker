#!/bin/bash
BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
stty sane
stty erase '^?'
# =========================================
# DECODER Utility
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
    echo " ██████╗ ███████╗ ██████╗ ██████╗ ██████╗ ███████╗██████╗ "
    echo " ██╔══██╗██╔════╝██╔════╝██╔═══██╗██╔══██╗██╔════╝██╔══██╗"
    echo " ██║  ██║█████╗  ██║     ██║   ██║██║  ██║█████╗  ██████╔╝"
    echo " ██║  ██║██╔══╝  ██║     ██║   ██║██║  ██║██╔══╝  ██╔══██╗"
    echo " ██████╔╝███████╗╚██████╗╚██████╔╝██████╔╝███████╗██║  ██║"
    echo " ╚═════╝ ╚══════╝ ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝"
    echo -e "${YELLOW}        Hashbreaker Framework by rushi20pute${NC}"
    echo
}

# -------- Helpers --------
is_base64() { [[ "$1" =~ ^[A-Za-z0-9+/=]+$ ]] && (( ${#1} % 4 == 0 )); }
is_base32() { [[ "$1" =~ ^[A-Z2-7=]+$ ]]; }
is_hex()    { [[ "$1" =~ ^[0-9a-fA-F]+$ ]] && (( ${#1} % 2 == 0 )); }
is_binary() { [[ "$1" =~ ^[01\ ]+$ ]]; }
is_url()    { [[ "$1" =~ %[0-9A-Fa-f]{2} ]]; }

print_result() {
    echo -e "${GREEN}"
    echo "--------------------------------------"
    echo "Decoded complete password is:"
    echo "--------------------------------------"
    echo -e "${NC}$1"
    echo
}

decode_all() {
    local data="$1"
    local found=false

    echo -e "${BLUE}--- Auto Detection Results ---${NC}"

    if is_base64 "$data"; then
        res=$(echo "$data" | base64 --decode 2>/dev/null)
        [[ -n "$res" ]] && echo -e "${GREEN}[+] Base64 detected${NC}" && print_result "$res" && found=true
    fi

    if is_base32 "$data"; then
        res=$(echo "$data" | base32 --decode 2>/dev/null)
        [[ -n "$res" ]] && echo -e "${GREEN}[+] Base32 detected${NC}" && print_result "$res" && found=true
    fi

    if is_hex "$data"; then
        res=$(echo "$data" | xxd -r -p 2>/dev/null)
        [[ -n "$res" ]] && echo -e "${GREEN}[+] Hex detected${NC}" && print_result "$res" && found=true
    fi

    if is_binary "$data"; then
        out=""
        for b in $data; do
            out+=$(printf "\\$(printf '%03o' "$((2#$b))")")
        done
        echo -e "${GREEN}[+] Binary detected${NC}"
        print_result "$out"
        found=true
    fi

    if is_url "$data"; then
        res=$(printf '%b\n' "${data//%/\\x}")
        echo -e "${GREEN}[+] URL encoding detected${NC}"
        print_result "$res"
        found=true
    fi

    # ROT13 fallback
    if ! $found; then
        echo -e "${YELLOW}[*] Trying ROT13 (heuristic)${NC}"
        res=$(echo "$data" | tr 'A-Za-z' 'N-ZA-Mn-za-m')
        print_result "$res"
    fi
}

# -------- Main --------
banner
echo -e "${CYAN}Enter encoded input (Base64 / Hex etc)${NC}"
echo -e "${YELLOW}[B] Back   [0] Exit${NC}"
echo
read -r input

case "$input" in
    B|b)
        bash "$BASE_DIR/hashbreaker.sh"
        exit 0
        ;;
    0)
        exit 0
        ;;
    *)
        echo
        decode_all "$input"
        echo
        echo -e "${YELLOW}Press Enter to decode another input, or B to go back.${NC}"
        read -r next
        if [[ "$next" =~ ^[Bb]$ ]]; then
            bash "$BASE_DIR/hashbreaker.sh"
            exit 0
        fi
        ;;
esac

