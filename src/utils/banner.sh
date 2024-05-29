#!/bin/bash

source "$(realpath ./src/core/global.sh)" "."
source "$(realpath ./src/core/message.sh)"

banner () {
  clear
  message "${COLORS['white']}" "
   ______   ______     ______     __  __     __  __     __    __     ______     ______
  /\  == \ /\  == \   /\  __ \   /\_\_\_\   /\ \_\ \   /\ \-./  \   /\  __ \   /\  == \ v1.0-dev-stable-r1
  \ \  _-/ \ \  __<   \ \ \/\ \  \/_/\_\/_  \ \____ \  \ \ \-./\ \  \ \  __ \  \ \  _-/
   \ \_\    \ \_\ \_\  \ \_____\   /\_\/\_\  \/\_____\  \ \_\ \ \_\  \ \_\ \_\  \ \_\   https://proxymaproject.com
    \/_/     \/_/ /_/   \/_____/   \/_/\/_/   \/_____/   \/_/  \/_/   \/_/\/_/   \/_/"  "\e[31m   (@BRNAREA)\e[0m"

  message "${COLORS['white']}" "
  +--
  Automated Proxy Scraper CLI Tool
  Copyright @ 2024-2024 BRNAREA (@BRNAREA)
  +--
  "
  message "${COLORS['red']}" "[!] "
  message "${COLORS['white']}" "I dont support illegal attacks using this tool, the responsibility is yours, only yours\n\n"
}
