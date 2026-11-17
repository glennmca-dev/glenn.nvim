# AGENTS.md — Guidelines for AI Agents Modifying This Config

## Overview

This is a Neovim configuration based on kickstart.nvim, heavily customized with
modular plugin files. The owner uses **Colemak-DH** keyboard layout — keybindings
may appear unusual but are intentional.

## Architecture

```
~/.config/nvim/
├── init.lua                          # Main config (kickstart base + lazy.nvim setup)
├── lua/
│   ├── kickstart/plugins/            # Upstream kickstart modules (rarely modified)
│   │   ├── lint.lua                  # nvim-lint config
│   │   ├── gitsigns.lua             # Git signs + keymaps
│   │   ├── autopairs.lua            # Auto bracket/quote pairing
│   │   ├── debug.lua                # DAP (DISABLED - not required)
│   │   ├── neo-tree.lua             # Neo-tree (DISABLED - nvim-tree used instead)
│   │   └── indent_line.lua          # Indent guides (DISABLED)
│   └── custom/
│       ├── plugins/
│       │   ├── init.lua             # Main custom plugins (snacks, dressing, bufferline, fine-cmdline)
│       │   ├── oil.lua              # File manager (directory editing, `-` to open)
│       │   ├── nvim-tree.lua        # Project tree (floating, `<C-n>` to toggle)
│       │   ├── search_highlight.lua # Custom lavender search highlights
│       │   ├── xml_change_version.lua # Custom `cv` mapping for XML version editing
│       │   └── markdown.lua         # render-markdown.nvim, image.nvim, diagram.nvim
│       └── keymaps/
│           └── keymap.lua           # All custom keybindings
└── lazy-lock.json                    # Plugin version lockfile
```

## Key Decisions

### Keyboard Layout: Colemak-DH
- The user types on Colemak-DH. Do NOT remap `hjkl` navigation — Neovim's
  native movement keys are already remapped mentally by the user.
- `<A-w>` cycles windows (instead of a Colemak-conflicting chord).
- `;` opens fine-cmdline (floating command input) — don't rebind it.

### File Explorers (Two, intentionally)
- **oil.nvim**: Directory editor, opened with `-`. Handles `vim .` style opening.
  `default_file_explorer = true`.
- **nvim-tree**: Project tree navigator, floating window, opened with `<C-n>`.
  Disables netrw. Used for project-level browsing.

### JavaScript/TypeScript/Node
- LSP: `ts_ls` (general JS/TS) and `angularls` (Angular projects), plus
  `eslint` for lint diagnostics/code actions via the LSP client.
- Formatting: conform.nvim runs `prettierd` (falling back to `prettier`) on
  save for `javascript`, `javascriptreact`, `typescript`, `typescriptreact`,
  `json`, `jsonc`, `css`, `html`, `yaml`, and `markdown`.
- `prettierd` is installed via `mason-tool-installer`; `eslint` is installed
  as a regular Mason LSP server (in the `servers` table, auto-installed).
- No Java/Groovy support — removed entirely (see git history for the old
  nvim-java/jdtls/groovyls setup if it's ever needed again).

### Markdown (rendering + diagrams)
- LSP: `marksman` (in the `servers` table). Formatting: `prettierd`/`prettier`
  via conform.nvim (see JS/TS section above — same formatter list).
- `lua/custom/plugins/markdown.lua` adds the *display* layer, separate from
  the LSP/formatter config in `init.lua`:
  - `MeanderingProgrammer/render-markdown.nvim` — styles headers, lists,
    tables, checkboxes, and code block borders directly in the buffer.
    Code block contents are highlighted via normal treesitter injections
    (`markdown`/`markdown_inline` parsers + the auto-install-on-`FileType`
    autocommand in the treesitter config pulls in whatever embedded language
    parser a fence needs — see the Treesitter section below).
  - `3rd/image.nvim` — image backend, `kitty` graphics protocol (owner's
    terminal is `xterm-kitty`). Requires the `magick` luarock installed via
    system `luarocks` (already done: `luarocks install magick`), *not* built
    by lazy.nvim (`build = false`) — don't add a `build` step back in.
  - `3rd/diagram.nvim` — detects ` ```mermaid ` (and `plantuml`/`d2`) fenced
    blocks and renders them as real images through image.nvim, shelling out
    to `mmdc` (mermaid-cli, installed via Homebrew) / `plantuml` / `d2`.
    Only `mmdc` is confirmed installed; plantuml/d2 blocks will fail
    silently-ish if those binaries aren't on PATH — that's expected, not a
    config bug, unless the owner asks for those diagram types.
- If diagrams stop rendering: check `:checkhealth image` first (backend/
  terminal/magick rock), then confirm `mmdc` is still on PATH.
- `mmdc` needs Puppeteer's `chrome-headless-shell` in
  `~/.cache/puppeteer`, which Homebrew's bottle does *not* bundle. One-time
  fix if diagrams error with "Could not find chrome-headless-shell":
  `cd /opt/homebrew/Cellar/mermaid-cli/*/libexec/lib/node_modules/@mermaid-js/mermaid-cli && npx puppeteer browsers install chrome-headless-shell`.

### No Debugging
- All DAP/debug plugins removed (Go)
- The kickstart debug.lua is commented out
- Don't re-add debug support without asking

### Dashboard
- Uses snacks.nvim dashboard (NOT alpha-nvim)
- Alpha was removed as dead code

### Treesitter: `main` branch, not `master`
- `nvim-treesitter/nvim-treesitter` is pinned `branch = 'main'` in `init.lua`.
  **Do not remove this pin or let a `Lazy sync` drift it** — upstream's
  default branch is `main`, but `master` (the old `nvim-treesitter.configs`
  opts-style API most kickstart configs/tutorials still show) is archived and
  only supported through Nvim 0.11. This box runs **Nvim 0.12.5**; on 0.12,
  `master`'s bundled markdown injection queries error
  (`set-lang-from-info-string!` directive assumes an old single-node
  query-match shape that Neovim's core query engine no longer produces),
  which breaks code-block language detection for render-markdown.nvim and
  diagram.nvim — this is exactly how the migration to `main` got triggered.
- `main` is a full rewrite: no `nvim-treesitter.configs` module, no
  `opts`/`ensure_installed`/`auto_install`/`highlight.enable`/`indent.enable`.
  The `config = function() ... end` in `init.lua` reimplements the same
  behavior by hand:
  - `require('nvim-treesitter').install({...})` for the explicit language
    list (equivalent of `ensure_installed`).
  - A `FileType` autocommand calls `vim.treesitter.start()` (+ installs the
    parser on first use via `.install(lang):wait()` if missing — equivalent
    of `auto_install = true`) and sets `indentexpr` to
    `require('nvim-treesitter').indentexpr()`, skipping `ruby` (equivalent of
    the old `indent.disable`).
- **Requires the `tree-sitter-cli` binary on PATH** (`brew install
  tree-sitter-cli` — note this is a *different* Homebrew formula from
  `tree-sitter`, which only ships the C library, not a `tree-sitter`
  executable). Without the CLI, parser installs fail with `Error during
  "tree-sitter build": ENOENT: no such file or directory (cmd): 'tree-sitter'`
  for every language main branch can't fetch a prebuilt binary for.
- If you see "failed to run config for nvim-treesitter" or treesitter errors
  mentioning `nvim-treesitter.configs`, someone reverted to old-API-style
  opts — restore the `branch = 'main'` + `config = function()` form instead
  of trying to fix the old opts table.

## Plugin Management

- Plugin manager: **lazy.nvim**
- `{ import = 'custom.plugins' }` auto-loads all files in `lua/custom/plugins/`
- `{ import = 'custom.keymaps' }` auto-loads keymaps
- Virtual plugin specs use `dir = vim.fn.stdpath 'config'` for config-only modules
  (search_highlight, keymaps) — no external dependency needed

## LSP Servers (managed by Mason)

Configured in `init.lua` under the `servers` table:
- gopls, pyright, angularls, bashls, dockerls, docker_compose_language_service
- jsonls, eslint, marksman, terraformls, ts_ls, yamlls, lua_ls, taplo

### How server config is wired (mason-lspconfig 2.x)

**Do not reintroduce `mason-lspconfig.setup { handlers = { ... } }`.** The
`handlers` option was removed in mason-lspconfig 2.x — it is still *accepted*
in the settings table but nothing reads it, so a handlers block fails silently
and every per-server `settings` table is dropped on the floor.

Instead, on Neovim 0.11+:
- `vim.lsp.config('*', { capabilities = capabilities })` broadcasts the
  nvim-cmp capabilities to every server once.
- `vim.lsp.config(name, opts)` per server merges overrides on top of the
  defaults nvim-lspconfig ships in its `lsp/` directory.
- `automatic_enable = vim.tbl_keys(servers)` restricts auto-enable to the
  servers we actually declare. Without it, mason-lspconfig enables *every*
  installed server — which made both markdown_oxide and marksman attach to
  markdown buffers at once.

Also avoid `require('lspconfig')[name].setup{}` — that framework path is
deprecated in favour of `vim.lsp.config`/`vim.lsp.enable`.

## Formatting

- `conform.nvim` handles formatting
- Go: goimports + gofumpt
- Lua: stylua
- Format on save enabled (except C/C++/Go which use LSP fallback)

## Important Notes for Agents

1. **Don't add in-editor AI plugins** — this config intentionally has none; AI tooling (omp/claude) lives outside nvim
2. **Don't add DAP plugins** — user explicitly doesn't debug
3. **Test with `luac -p`** before claiming a file is valid
4. **Respect the module pattern** — each file in `custom/plugins/` returns a
   lazy.nvim plugin spec (table or table of tables)
5. **Keep the snacks.nvim dashboard** — don't add alpha-nvim or dashboard-nvim
6. **XML version tool** (`cv` in normal mode) — custom utility for pom.xml editing,
   don't remove it
7. **fine-cmdline** (`;` binding) — user actively uses this, don't replace with
   native `:` or noice.nvim
8. When adding new plugins, prefer adding a new file in `custom/plugins/` rather
   than modifying `init.lua`
9. The `lazy-lock.json` will be regenerated on next `:Lazy sync` — don't manually edit it
10. **Neovim 0.11 API hygiene** — use `vim.hl.on_yank()` (not `vim.highlight`)
    and `client:supports_method()` (colon, not dot). The old forms are
    deprecated shims scheduled for removal in 0.12.
11. **Verify LSP changes by actually attaching a client**, not by reading the
    config. Both bugs above (dropped `settings`, duplicate markdown servers)
    looked completely fine on paper. Check with:
    `nvim --headless -c 'lua vim.defer_fn(function() print(vim.inspect(vim.lsp.get_clients({bufnr=0})[1].settings)) vim.cmd("qa!") end, 5000)' <file>`
