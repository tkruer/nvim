#!/usr/bin/env bash
#
#
set -euo pipefail

################################################################################
# 1. Helpers
################################################################################
color() { printf "\033[%sm%s\033[0m" "$1" "$2"; }
msg() {
    color "1;34" "==>"
    echo " $*"
} # blue bold headline
have() { command -v "$1" >/dev/null 2>&1; }

brew_install() {
    for pkg in "$@"; do
        if brew ls --versions "$pkg" >/dev/null; then
            msg "$pkg already installed"
        else
            msg "brew install $pkg"
            brew install "$pkg"
        fi
    done
}

brew_cask() {
    for c in "$@"; do
        if brew ls --cask --versions "$c" >/dev/null; then
            msg "$c (cask) already installed"
        else
            msg "brew install --cask $c"
            brew install --cask "$c"
        fi
    done
}

npm_global() {
    if have bun; then pkg_mgr="bun"; else pkg_mgr="npm"; fi
    for p in "$@"; do
        if "$pkg_mgr" list -g --depth=0 "$p" >/dev/null 2>&1; then
            msg "$p (JS) already installed"
        else
            msg "$pkg_mgr install -g $p"
            "$pkg_mgr" install -g "$p"
        fi
    done
}

go_install() {
    for mod in "$@"; do
        bin=$(basename "${mod%%@*}")
        if have "$bin"; then
            msg "$bin (Go) already installed"
        else
            msg "go install $mod"
            GOFLAGS=-buildvcs=false go install "$mod"
        fi
    done
}

cargo_install() {
    for crate in "$@"; do
        if cargo install --list | grep -q "^$crate v"; then
            msg "$crate (Rust) already installed"
        else
            msg "cargo install $crate"
            cargo install "$crate"
        fi
    done
}

pip_install() {
    PY=$(command -v python3 || command -v python)
    for mod in "$@"; do
        if "$PY" -m pip show "$mod" >/dev/null 2>&1; then
            msg "$mod (pip) already installed"
        else
            msg "pip install --upgrade $mod"
            "$PY" -m pip install --upgrade "$mod"
        fi
    done
}

gem_install() {
    for gem in "$@"; do
        if gem list -i "$gem" >/dev/null 2>&1; then
            msg "$gem (gem) already installed"
        else
            msg "gem install $gem"
            gem install "$gem"
        fi
    done
}

################################################################################
# 2. Ensure Homebrew
################################################################################
if ! have brew; then
    msg "Installing Homebrew (this will prompt for sudo)…"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv || /usr/local/bin/brew shellenv)"
else
    msg "Updating Homebrew…"
    brew update
fi

################################################################################
# 3. Homebrew formulae & casks
################################################################################
brew_install \
    ripgrep fd git jq cmake wget curl unzip coreutils \
    lua@5.1 luarocks deno julia \
    imagemagick ghostscript tectonic \
    node yarn bun \
    go python@3.11 rustup-init \
    lazygit neovim zsh

# Optional GUI/Tex cask (big download; comment if you prefer only tectonic)
brew_cask mactex-no-gui

################################################################################
# 4. Java, Rust, Go tool-chains
################################################################################
# Java (for jdtls / java-language-server) is already present via Homebrew’s openjdk.
if ! have rustup; then
    msg "Installing Rust tool-chain…"
    rustup-init -y
    source "$HOME/.cargo/env"
fi

################################################################################
# 5. npm / bun global CLI tools (LSPs, formatters, linters, etc.)
################################################################################
npm_global \
    prettier @fsouza/prettierd \
    bash-language-server \
    vscode-langservers-extracted \
    vscode-css-languageserver-bin \
    vscode-html-languageserver-bin \
    vscode-json-languageserver \
    dockerfile-language-server-nodejs docker-compose-language-service \
    yaml-language-server @biomejs/biome \
    emmet-ls \
    eslint-language-server \
    tailwindcss-language-server \
    typescript typescript-language-server \
    sql-language-server \
    mermaid-cli

################################################################################
# 6. Go-based tools
################################################################################
go_install \
    golang.org/x/tools/gopls@latest \
    github.com/go-delve/delve/cmd/dlv@latest \
    github.com/segmentio/golines@latest \
    github.com/josharian/impl@latest \
    github.com/fatih/gomodifytags@latest \
    mvdan.cc/gofumpt@latest \
    github.com/rakyll/hey@latest

################################################################################
# 7. Cargo-based extras (none are hard requirements, add more if needed)
################################################################################
cargo_install taplo-cli sqlx-cli

################################################################################
# 8. Python, Ruby & Perl providers
################################################################################
pip_install pynvim
gem_install neovim
# Perl provider: optional – install the CPAN module if you actually need it.
# sudo cpanm Neovim::Ext

################################################################################
# 9. Mason: bulk-install remaining LSP/dap/formatter binaries
################################################################################
msg "Letting Mason.nvim grab everything else (runs headless Neovim)…"
nvim --headless +"lua require('mason').setup()" +'MasonUpdate -q' +'MasonInstall -q bash-language-server biome clangd css-lsp deno docker-compose-language-service dockerls emmet-ls eslint-lsp gopls html-lsp java-language-server jdtls json-lsp lua-language-server marksman neocmake pyright rust-analyzer sqls tailwindcss-ls taplo typescript-language-server vim-language-server vtsls yamlls zls' +qa

msg "🎉  All done.  Restart your terminal and Neovim."
