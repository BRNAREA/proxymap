#!/bin/bash

# Load globals definitions
source "$(realpath src/core/global.sh)" "."
source "$(realpath src/core/message.sh)"

# Create symlinks -- Links proxymap to PATH system
create_symlinks () {
    if [ ! -x "$BPATH/proxymap" ]; then
        ln -sf "$PROXYMAP" "$BPATH/proxymap"
        if $? ;then
          message "${COLORS['green']}" "Linked successfully! \n"
        else
          message "${COLORS['red']}" "Error \nYour $BPATH has the right permissions ? chown and chmod ?"
          exit 1
        fi
    fi
}

# Setup proxy-scraper
configure () {
    if [ ! -d "$WORKDIR/lib" ]; then
        message "${COLORS['red']}" "No WORKDIR set \n"
        read -r -p "Install/Re-install ? (Y/n)" choice
        if [[ "$choice" =~ ^[Yy]?$|^$ ]]; then
            message "${COLORS['green']}" "Installing.."
            remake
        else
            message "${COLORS['yellow']}" "Aborting.. \n"
            exit 0
        fi
    else
        make
    fi
}

# Create venv
make () {
    message "${COLORS['green']}" " [+] Creating virtual environment\n"
    if [ ! -d "$VENVPATH" ]; then
        python3 -m venv "$VENVPATH"
    fi
    make_install
}

# Active venv
make_install () {
    mkdir -p "$PROXYDIR"
    mkdir -p "$PROXYDIR2"
    source "$VENVPATH/bin/activate"
    message "${COLORS['green']}" " [+] Entering virtual environment\n"
    pip3 install -r "$REQUIREMENTS_PATH" --quiet
}

# Reinstall proxymap
remake () {
    git submodule deinit -f .git/modules/lib/proxy-scraper
    git rm -f lib/proxy-scrape
    rm -rf .git/modules/lib/proxy-scraper
    git submodule add https://github.com/BRNAREA/proxy-scraper.git lib/proxy-scraper
    git submodule update --init --recursive
    configure
}

# Setup proxymap
setup () {
  create_symlinks
  configure
}
