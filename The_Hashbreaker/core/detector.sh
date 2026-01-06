#!/bin/bash

# =========================================
# Hash Type Detector
# Used by HashBreaker Framework
# =========================================

detect_hash_type() {
    local HASH="$1"
    local LEN="${#HASH}"

    # lowercase normalize (safe)
    HASH="$(echo "$HASH" | tr 'A-F' 'a-f')"

    # Regex helpers
    is_hex='^[a-f0-9]+$'
    is_b64='^[A-Za-z0-9+/]+={0,2}$'

    # ---- HEX based hashes ----
    if [[ "$HASH" =~ $is_hex ]]; then
        case "$LEN" in
            32)
                echo "MD5"
                return
                ;;
            40)
                echo "SHA1"
                return
                ;;
            56)
                echo "SHA224"
                return
                ;;
            64)
                echo "SHA256"
                return
                ;;
            96)
                echo "SHA384"
                return
                ;;
            128)
                echo "SHA512"
                return
                ;;
        esac
    fi

    # ---- Base64 (encoded, not hash) ----
    if [[ "$HASH" =~ $is_b64 ]]; then
        echo "BASE64"
        return
    fi

    # ---- Unknown ----
    echo "UNKNOWN"
}

# ---- Standalone test mode ----
# Allows running detector.sh directly
if [[ "$0" == *"detector.sh" ]]; then
    echo
    read -r -p "Enter hash / encoded value: " INPUT
    TYPE="$(detect_hash_type "$INPUT")"
    echo "Detected Type: $TYPE"
    echo
    read -p "Press Enter to return..." _
fi
