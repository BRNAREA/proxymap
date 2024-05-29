#!/bin/bash

source "$(realpath ./src/core/global.sh)" "."
source "$(realpath ./src/core/message.sh)"

filter_proxies() {
  local response="$1"

  read -r -p " [+] Specific country? (leave blank if you dont want specific country) " country
  read -r -p " [+] Specific type? (HTTP, HTTPS, SOCKS4, SOCKS5)? " type

  case "$type" in
    "${types[1]}")
      type_num=0
      ;;
    "${types[2]}")
      type_num=1
      ;;
    "${types[3]}")
      type_num=2
      ;;
    "${types[4]}")
      type_num=3
      ;;
    *)
      echo "Unknow type"
      exit 1
      ;;
  esac

  local tmpfile
  tmpfile=$(mktemp)
  echo "$response" | jq -c ".[] | select(.addr_geo_country == \"$country\" and .type == $type_num) | {addr: .addr, ip_geo_location: .addr_geo_country, type: .type, timeout: .timeout}" > "$tmpfile"

  while IFS= read -r proxy; do
    addr=$(echo "$proxy" | jq -r '.addr')
    ip_geo_location=$(echo "$proxy" | jq -r '.ip_geo_location')
    type=$(echo "$proxy" | jq -r '.type')
    timeout=$(echo "$proxy" | jq -r '.timeout')

    message "${COLORS['green']}" "#-----------------------------------#\n"
    message "${COLORS['green']}" "[+] Proxy: $addr\n"
    message "${COLORS['green']}" "[+] Country: $ip_geo_location\n"
    message "${COLORS['green']}" "[+] Type: ${types[$type_num]}\n"
    message "${COLORS['green']}" "[+] Timeout: $timeout\n"
    message "${COLORS['green']}" "#-----------------------------------#\n"

    echo "$addr" >> "$PROXYDIR2/${types[$type_num]}.txt"
  done < "$tmpfile"

  rm "$tmpfile"
}

filter () {
  for type in "${OPTIONS[@]::${#OPTIONS[@]}-3}"; do
      local file temp_file
      file="$PROXYDIR/${type}.txt"
      temp_file="${type}.tmp"
      : > "$temp_file"
      while IFS= read -r proxy; do
        echo "$type ${proxy//:/ }" >> "$temp_file"
      done < "$file"
      mv "$temp_file" "$file"
  done
}
