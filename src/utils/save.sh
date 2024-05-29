#!/bin/bash

source "$(realpath ./src/core/global.sh)" "."
source "$(realpath ./src/core/message.sh)"

save () {
  read -r -p "Create a proxychains4 config? (y/n) " choice
  if [[ "$choice" =~ ^[Yy]?$|^$ ]]; then
    message "${COLORS['green']}" " [+] Creating proxychains4.conf...\n"
    local temp_file
    temp_file=$(mktemp)
    sed '/^\[ProxyList\]/,$d' "$PROXYCHAINS_FILE" > "$temp_file"
    echo "[ProxyList]" >> "$temp_file"
    for type in "${OPTIONS[@]::${#OPTIONS[@]}-3}"; do
      local file="$PROXYDIR/${type}.txt"
      while IFS= read -r proxy; do
        echo "$proxy" >> "$temp_file"
      done < "$file"
    done
    mv "$temp_file" "$PROXYCHAINS_FILE"
    message "${COLORS['green']}" " [+] proxychains4.conf updated at $PROXYCHAINS_FILE\n"
    return 0
  else
    message "${COLORS['yellow']}" " [-] Ok, exiting.\n"
    exit 0
  fi
}


