# glenn.nvim

## Introduction

A customized Neovim configuration based on kickstart.nvim that is:

* Well-documented
* Modular plugin structure  
* AI-enhanced development environment
* Comprehensive language support

This configuration extends kickstart.nvim with custom plugins and configurations for modern development workflows.

## Installation

### Install Neovim

Kickstart.nvim targets *only* the latest
['stable'](https://github.com/neovim/neovim/releases/tag/stable) and latest
['nightly'](https://github.com/neovim/neovim/releases/tag/nightly) of Neovim.
If you are experiencing issues, please make sure you have the latest versions.

### Install External Dependencies

External Requirements:
- Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
- Clipboard tool (xclip/xsel/win32yank or other depending on platform)
- A [Nerd Font](https://www.nerdfonts.com/): optional, provides various icons
  - if you have it set `vim.g.have_nerd_font` in `init.lua` to true
- Language Setup:
  - If you want to write Typescript, you need `npm`
  - If you want to write Golang, you will need `go`
  - etc.

**Quick Install on macOS (using Homebrew):**
```bash
# Install Neovim and basic dependencies
brew install neovim git make ripgrep gcc node go

# Install a Nerd Font (optional but recommended)
brew install --cask font-jetbrains-mono-nerd-font

# Note: pbcopy/pbpaste are built into macOS for clipboard functionality
```

> **NOTE**
> See [Install Recipes](#install-recipes) for additional Windows and Linux specific notes
> and quick install snippets

### Install glenn.nvim

> **NOTE**
> [Backup](#faq) your previous configuration (if any exists)

Neovim's configurations are located under the following paths, depending on your OS:

| OS | PATH |
| :- | :--- |
| Linux, MacOS | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| Windows (cmd)| `%localappdata%\nvim\` |
| Windows (powershell)| `$env:LOCALAPPDATA\nvim\` |

#### Recommended Step

[Fork](https://docs.github.com/en/get-started/quickstart/fork-a-repo) this repo
so that you have your own copy that you can modify, then install by cloning the
fork to your machine using one of the commands below, depending on your OS.

#### Clone glenn.nvim
> **NOTE**
> If following the recommended step above (i.e., forking the repo), replace
> `glennmca-dev` with `<your_github_username>` in the commands below

<details><summary> Linux and Mac </summary>

```sh
git clone https://github.com/glennmca-dev/glenn.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

</details>

### Post Installation

Start Neovim

```sh
nvim
```

That's it! Lazy will install all the plugins you have. Use `:Lazy` to view
current plugin status. Hit `q` to close the window.

Read through the `init.lua` file in your configuration folder for more
information about extending and exploring Neovim. That also includes
examples of adding popularly requested plugins.

## Configuration Overview

### Main Features

This configuration includes 35+ carefully selected plugins organized into categories:

**🚀 Core Features:**
- **AI-Powered Development**: Avante.nvim with Claude Sonnet 4 integration via Copilot
- **Advanced LSP**: Mason-managed LSP servers for 10+ languages
- **Modern UI**: Catppuccin theme, bufferline, floating windows, and enhanced notifications
- **Smart Search**: Telescope with fuzzy finding and live grep capabilities
- **File Management**: Dual file explorers (nvim-tree and neo-tree)

### Language Server Protocol (LSP) Support

Configured LSP servers for comprehensive language support:

- **Go** (`gopls`) - Full Go development support
- **Python** (`pyright`) - Python type checking and intellisense  
- **JavaScript/TypeScript** (`ts_ls`) - Modern JS/TS development
- **Java** (`jdtls`) - Enterprise Java with Lombok support
- **Angular** (`angularls`) - Angular framework support
- **Bash** (`bashls`) - Shell scripting
- **Docker** (`dockerls`, `docker_compose_language_service`) - Container development
- **Infrastructure as Code** (`terraformls`) - Terraform support
- **Groovy** (`groovyls`) - Jenkins/Gradle support  
- **Configuration Files** (`jsonls`, `yamlls`) - JSON/YAML editing
- **Documentation** (`marksman`) - Markdown editing
- **Lua** (`lua_ls`) - Neovim configuration development

### Key Plugins by Category

**🧠 AI & Development:**
- `yetone/avante.nvim` - AI coding assistant with Claude integration
- `nvim-java/nvim-java` - Advanced Java development environment

**🔍 Navigation & Search:**
- `nvim-telescope/telescope.nvim` - Fuzzy finder for files, text, and more
- `nvim-tree/nvim-tree.lua` - File explorer with git integration
- `folke/which-key.nvim` - Interactive keybinding help

**⚡ LSP & Completion:**
- `neovim/nvim-lspconfig` - LSP client configurations
- `hrsh7th/nvim-cmp` - Autocompletion framework
- `williamboman/mason.nvim` - LSP server, formatter, and linter manager

**🎨 UI & Appearance:**
- `catppuccin/nvim` - Modern color scheme
- `akinsho/bufferline.nvim` - Enhanced buffer tabs
- `folke/snacks.nvim` - Notification system and utilities
- `echasnovski/mini.nvim` - Collection of useful micro-plugins

**⚙️ Development Tools:**
- `lewis6991/gitsigns.nvim` - Git integration and change tracking
- `stevearc/conform.nvim` - Code formatting
- `mfussenegger/nvim-lint` - Linting support
- `windwp/nvim-autopairs` - Automatic bracket/quote pairing

**🖥️ Terminal & Interface:**
- `akinsho/toggleterm.nvim` - Integrated terminal management
- `VonHeikemen/fine-cmdline.nvim` - Enhanced command line interface

### Custom Keymaps

The configuration includes intuitive keybindings:

- `<leader>ff` - Find files
- `<leader>fw` - Live grep search  
- `<leader>fb` - Browse buffers
- `<C-n>` - Toggle file tree
- `<leader>gg` - Open lazygit
- `<C-s>` - Save file
- `;` - Enhanced command line
- And many more...

### Getting Started

[The Only Video You Need to Get Started with Neovim](https://youtu.be/m8C0Cq9Uv9o)

### Install Recipes

Below you can find OS specific install instructions for Neovim and dependencies.

After installing all the dependencies continue with the [Install glenn.nvim](#install-glennvim) step.

#### Linux Install
<details><summary>MacOs Install steps</summary>
  ```
  brew install neovim
  ```
</details>

#### Linux Install
<details><summary>Ubuntu Install Steps</summary>

```
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip neovim
```
</details>
<details><summary>Debian Install Steps</summary>

```
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip curl

# Now we install nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim-linux64
sudo mkdir -p /opt/nvim-linux64
sudo chmod a+rX /opt/nvim-linux64
sudo tar -C /opt -xzf nvim-linux64.tar.gz

# make it available in /usr/local/bin, distro installs to /usr/bin
sudo ln -sf /opt/nvim-linux64/bin/nvim /usr/local/bin/
```
</details>
<details><summary>Fedora Install Steps</summary>

```
sudo dnf install -y gcc make git ripgrep fd-find unzip neovim
```
</details>

<details><summary>Arch Install Steps</summary>

```
sudo pacman -S --noconfirm --needed gcc make git ripgrep fd unzip neovim
```
</details>

