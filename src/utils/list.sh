#!/bin/bash

source "$(realpath ./src/core/global.sh)" "."
source "$(realpath ./src/core/message.sh)"
source "$(realpath ./src/utils/save.sh)"

list () {
  read -r -p "List proxies? (Y/n) " choice
  if [[ "$choice" =~ ^[Yy]?$|^$ ]]; then
    message "${COLORS['white']}" "Proxies available \n"
    sed -n -e '/\[ProxyList\]/,${p}' "$PROXYCHAINS_FILE" | while IFS= read -r line; do
      sleep 0
      message "${COLORS['green']}" " [+] "
      message "${COLORS['white']}" "$line "
      message "${COLORS['green']}" "Ok.\n"
    done
  else
    message "${COLORS['white']}" "Ok. Skipping\n"
  fi
  save
}
