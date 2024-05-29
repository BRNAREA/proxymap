#!/bin/bash

# Carrega as definições globais
source "$(realpath ./src/core/global.sh)" "."

# Define a função de mensagem
message () {
    echo -ne "$1$2${COLORS['reset']}$3${COLORS['reset']}$4${COLORS['reset']}"
}

