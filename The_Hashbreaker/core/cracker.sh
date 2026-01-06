#!/bin/bash
#This code is For result directory stores logs we will implement this later after adding more wordlists to framework
#RESULTS_DIR="$BASE_DIR/../results"
#CRACKED_FILE="$RESULTS_DIR/cracked.txt"
#NOT_FOUND_FILE="$RESULTS_DIR/not_found.txt"
#mkdir -p "$RESULTS_DIR"


# ===============================
# CRACKER - HashBreaker Framework
# ===============================

# ---- TERMINAL FIX ----
stty sane
stty erase ^?
trap "stty sane; echo; exit" INT TERM

# ---- COLORS ----
RED='\033[1;31m'
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
NC='\033[0m'

# ---- PATHS (FIXED) ----
BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
WORDLIST_DIR="$BASE_DIR/wordlists"

# ---- BANNER ----
banner() {
    clear
    echo -e "${RED}"
    echo " ██████╗ ██████╗  █████╗  ██████╗██╗  ██╗███████╗██████╗ "
    echo "██╔════╝ ██╔══██╗██╔══██╗██╔════╝██║ ██╔╝██╔════╝██╔══██╗"
    echo "██║      ██████╔╝███████║██║     █████╔╝ █████╗  ██████╔╝"
    echo "██║      ██╔══██╗██╔══██║██║     ██╔═██╗ ██╔══╝  ██╔══██╗"
    echo "╚██████╗ ██║  ██║██║  ██║╚██████╗██║  ██╗███████╗██║  ██║"
    echo " ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝"
    echo -e "${NC}"
    echo -e "${BLUE}               Part of HashBreaker Framework${NC}"
    echo -e "${YELLOW}                    Made by Rushi${NC}"
    echo "=============================================================="
    echo
}

# ---- HASH TYPE DETECTOR ----
detect_hash() {
    local len=${#1}
    case $len in
        32)  echo "MD5_OR_NTLM" ;;
        40)  echo "SHA1" ;;
        56)  echo "SHA224" ;;
        64)  echo "SHA256" ;;
        96)  echo "SHA384" ;;
        128) echo "SHA512" ;;
        *)   echo "UNKNOWN" ;;
    esac
}

# ---- PROGRESS BAR ----
progress_bar() {
    local current=$1
    local total=$2
    local percent=$(( current * 100 / total ))
    local filled=$(( percent / 2 ))
    local empty=$(( 50 - filled ))

    printf "\r["
    printf "%0.s#" $(seq 1 $filled)
    printf "%0.s-" $(seq 1 $empty)
    printf "] %d%% (%d/%d)" "$percent" "$current" "$total"
}

# ---- PASSWORD FOUND ----
password_found() {
    clear
    for i in {1..3}; do
        echo -e "${GREEN}PASSWORD FOUND${NC}"
        sleep 0.3
        clear
    done

    echo "======================================"
    echo -e "${GREEN}   PASSWORD CRACKED SUCCESSFULLY${NC}"
    echo "======================================"
    echo -e "${YELLOW}Target Hash : $TARGET_HASH${NC}"
    echo -e "${BLUE}Hash Type   : $HASH_TYPE${NC}"
    echo -e "${YELLOW}Password    : $1${NC}"
    echo -e "${BLUE}Wordlist    : $2${NC}"
    echo
    exit 0
}

# ===============================
# MAIN LOGIC
# ===============================

banner

read -erp "Enter target hash: " TARGET_HASH
HASH_TYPE=$(detect_hash "$TARGET_HASH")

if [[ "$HASH_TYPE" == "UNKNOWN" ]]; then
    echo "[-] Unsupported or invalid hash"
    exit 1
fi

echo "[+] Detected hash type: $HASH_TYPE"
echo

# ---- SAFETY CHECK ----
if ! ls "$WORDLIST_DIR"/*.txt >/dev/null 2>&1; then
    echo "[-] No wordlists found in $WORDLIST_DIR"
    exit 1
fi

for wordlist in "$WORDLIST_DIR"/*.txt; do
    echo "[*] Trying wordlist: $(basename "$wordlist")"

    total=$(wc -l < "$wordlist")
    count=0

    while IFS= read -r word; do
        ((count++))

        case "$HASH_TYPE" in
            MD5_OR_NTLM)
                gen=$(echo -n "$word" | md5sum | awk '{print $1}')
                if [[ "$gen" == "$TARGET_HASH" ]]; then
                    HASH_TYPE="MD5"
                    password_found "$word" "$(basename "$wordlist")"
                fi

               #ntlm=$(echo -n "$word" | iconv -t utf16le | md4sum | awk '{print $1}')
                ntlm=$(echo -n "$word" | iconv -t utf16le | openssl md4 | awk '{print $2}')
                if [[ "$ntlm" == "$TARGET_HASH" ]]; then
                    HASH_TYPE="NTLM"
                    password_found "$word" "$(basename "$wordlist")"
                fi
                ;;
            SHA1)   gen=$(echo -n "$word" | sha1sum | awk '{print $1}') ;;
            SHA224) gen=$(echo -n "$word" | sha224sum | awk '{print $1}') ;;
            SHA256) gen=$(echo -n "$word" | sha256sum | awk '{print $1}') ;;
            SHA384) gen=$(echo -n "$word" | sha384sum | awk '{print $1}') ;;
            SHA512) gen=$(echo -n "$word" | sha512sum | awk '{print $1}') ;;
        esac

        [[ "$gen" == "$TARGET_HASH" ]] && password_found "$word" "$(basename "$wordlist")"
        progress_bar "$count" "$total"

    done < "$wordlist"

    echo
done

echo
echo "[-] Password not found in provided wordlists"
exit 1
