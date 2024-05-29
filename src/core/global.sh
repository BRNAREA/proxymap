#!/bin/bash

# Definições globais
export WORKDIR=$(realpath "$1")
export PROXYSCRAPER_PATH="$WORKDIR/lib/proxy-scraper"
export BPATH="/usr/local/bin"
export VENVPATH="$PROXYSCRAPER_PATH/.venv"
export REQUIREMENTS_PATH="$PROXYSCRAPER_PATH/requirements.txt"
export PROXYMAP=$(realpath bin/proxymap)
export SCRAPER=$(realpath src/core/scraper.sh)
export PROXYSCRAPER="python3 $PROXYSCRAPER_PATH/proxyScraper.py"
export PROXYCHECKER="python3 $PROXYSCRAPER_PATH/proxyChecker.py"
export PROXYDIR="$PROXYSCRAPER_PATH/proxies"
export PROXYDIR2="$PROXYSCRAPER_PATH/proxies.bkp"
export PROXYCHAINS_FILE="$(realpath .)/proxychains.conf"

declare -A COLORS=(
    [reset]="\e[0m"
    [green]="\e[32m"
    [red]="\e[31m"
    [yellow]="\e[33m"
    [black]="\e[30m"
    [blue]="\e[34m"
    [magenta]="\e[35m"
    [cyan]="\e[36m"
    [white]="\e[37m"
)

declare -A types=(
    [1]=http
    [2]=https
    [3]=socks4
    [4]=socks5
)

declare -A sites=(
    [0]="https://checkerproxy.net/api/archive/$(date +%F)"
)

declare -A site_alias=(
    [0]="checkerproxy.net"
)

declare -g OPTIONS=(
    "http"
    "https"
    "socks4"
    "socks5"
    "all"
    "check"
    "quit"
)

