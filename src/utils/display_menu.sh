#!/bin/bash

# Carrega as definições globais
source "$(realpath ./src/core/global.sh)" "."
source "$(realpath ./src/core/message.sh)"
source "$(realpath ./src/core/scraper.sh)"
source "$(realpath ./src/utils/banner.sh)"

# Define a função de exibição do menu
display_menu() {
    clear
    banner
    tput cup 12 10
    message "${COLORS['red']}" "1) proxymap"
    tput cup 12 30
    message "${COLORS['red']}" "2) scraper"
    tput cup 12 50
    message "${COLORS['red']}" "3) quit"
    tput cup 14 0
    message "${COLORS['red']}" " [-] Make your selection: "

    read -r choice
    case $choice in
        1) scraper_one;;
        2) scraper_two;;
        3)
            message "${COLORS['green']}" "Exiting! \n"
            exit 0
            ;;
        *)
            message "${COLORS['red']}" "Invalid option $choice\n"
            ;;
    esac
}

