#!/bin/bash

# Carrega as definições globais
source "$(realpath ./src/core/global.sh)" "lib/proxy-scraper"
source "$(realpath ./src/core/message.sh)"
source "$(realpath ./src/utils/filter.sh)"
source "$(realpath ./src/utils/check.sh)"
source "$(realpath ./src/utils/list.sh)"

# Default function to scrap proxies
scraper_one () {
    message "${COLORS['white']}" "Choose type to scrape.\n"
    select type in "${OPTIONS[@]}"; do
        case $type in
            http|https|socks4|socks5)
                $PROXYSCRAPER -p "$type" -o "$PROXYDIR/$type.txt"
                message "${COLORS['green']}" " [+] $type scraped! \n"
                scraper_one
                ;;
            all)
                for type in "${OPTIONS[@]::${#OPTIONS[@]}-3}"; do
                    $PROXYSCRAPER -p "$type" -o "$PROXYDIR/$type.txt"
                    message "${COLORS['green']}" " [+] $type scraped! \n"
                done
                read -r -p "Check the proxies (Y/n) ? " choice
                if [[ "$choice" =~ ^[Yy]?$|^$ ]]; then
                  message "${COLORS['green']}" "Checking..\n"
                  check
                else
                  list
                fi
                return 0
                ;;
            check)
                check
                ;;
            quit|q)
                message "${COLORS['green']}" "Exiting! \n"
                exit 0
                ;;
            *)
                message "${COLORS['red']}" "Invalid option $REPLY \n"
                ;;
        esac
    done
}

# Alterantive method to get proxies
scraper_two() {
    local user_agent
    user_agent=$(shuf -n 1 "$PROXYSCRAPER_PATH/user_agents.txt")

    local response
    response=$(curl -s "${sites[0]}" --compressed \
        -H "$user_agent" \
        -H 'Accept: */*' \
        -H 'Accept-Language: en-US,en;q=0.5' \
        -H 'Accept-Encoding: gzip, deflate, br' \
        -H "Referer: ${sites[0]}" \
        -H "Alt-Used: ${site_alias[0]}" \
        -H 'Connection: keep-alive' \
        -H 'Sec-Fetch-Dest: empty' \
        -H 'Sec-Fetch-Mode: cors' \
        -H 'Sec-Fetch-Site: same-origin' \
        -H 'Sec-GPC: 1' \
        -H 'TE: trailers'
    )

    filter_proxies "$response"
}
