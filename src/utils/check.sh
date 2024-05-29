#!/bin/bash

# Load global definitions
source "$(realpath ./src/core/global.sh)" "."
source "$(realpath ./src/core/message.sh)"
source "$(realpath ./src/utils/list.sh)"

# Check proxies one 1:1
check () {
    message "${COLORS['yellow']}" " [-] Checking only live proxies...\n"
    message "${COLORS['yellow']}" " [-] This can take a while\n"

    for type in "${OPTIONS[@]::${#OPTIONS[@]}-3}"; do
        message "${COLORS['green']}" " [+] Checking proxy $type\n"
        if [ "$type" == "http" ] || [ "$type" == "https" ]; then
            $PROXYCHECKER -p "$type" -t 20 -r -s https://www.example.com -l "$PROXYDIR/$type.txt"
        else
            $PROXYCHECKER -p "$type" -t 20 -r -s https://icanhazip.com -l "$PROXYDIR/$type.txt"
        fi
    done
    list
}

