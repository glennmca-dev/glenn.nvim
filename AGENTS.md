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
│       │   ├── init.lua             # Main custom plugins (Java, snacks, dressing, bufferline, fine-cmdline)
│       │   ├── oil.lua              # File manager (directory editing, `-` to open)
│       │   ├── nvim-tree.lua        # Project tree (floating, `<C-n>` to toggle)
│       │   ├── search_highlight.lua # Custom lavender search highlights
│       │   └── xml_change_version.lua # Custom `cv` mapping for XML version editing
│       └── keymaps/
│           └── keymap.lua           # All custom keybindings
├── ftdetect/
│   └── jenkinsfile.lua              # Jenkinsfile filetype detection
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

### Java (nvim-java)
- Uses the latest nvim-java with `vim.lsp.enable('jdtls')` API (Neovim 0.11+)
- Lombok enabled, Spring Boot tools enabled, testing enabled
- Debug adapter DISABLED (user doesn't debug)
- **JDK: `jdk.auto_install = false`.** nvim-java's auto-installer downloads from
  a `download.oracle.com` URL that returns HTTP 403 — it cannot be relied on.
- **jdtls 1.54 must run on Java 21-25**, even for projects targeting Java 17.
  `java` on PATH here is mise's global Java 17, so `jdk.path` is resolved at
  startup by scanning `~/.local/share/mise/installs/java/*` for the newest
  21-25 install. This only sets the JVM jdtls *runs on*.
- **Project Java level comes from the build file, not from mise.** jdtls reads
  `maven.compiler.source` / the Gradle equivalent to set the source level, and
  enforces it correctly (Java 21 syntax errors in a Java 17 pom). A `mise.toml`
  pinning `java = "zulu-17"` does *not* by itself change the source level —
  mise governs the `java`/`mvn` binaries in your shell, while jdtls is a
  long-lived process that does its own per-project resolution.
- All mise JDKs are advertised to jdtls via
  `settings.java.configuration.runtimes` (the `JavaSE-<n>` execution
  environments), so jdtls can *select* the matching JDK for whatever level a
  project declares. Without this the runtimes list is empty and jdtls falls
  back to its own JVM for anything it can't infer from the build file.
- Files outside a recognised project ("non-project file, only syntax errors are
  reported") get no source-level enforcement at all — that's expected jdtls
  behaviour, not a config bug.
- Don't pin `lombok.version` — nvim-java pins the release matching its jdtls
  version (1.18.42 for jdtls 1.54). A hard-coded 1.18.40 breaks annotation
  processing on Java 25.

### No Debugging
- All DAP/debug plugins removed (Go, Java)
- The kickstart debug.lua is commented out
- Don't re-add debug support without asking

### Dashboard
- Uses snacks.nvim dashboard (NOT alpha-nvim)
- Alpha was removed as dead code

## Plugin Management

- Plugin manager: **lazy.nvim**
- `{ import = 'custom.plugins' }` auto-loads all files in `lua/custom/plugins/`
- `{ import = 'custom.keymaps' }` auto-loads keymaps
- Virtual plugin specs use `dir = vim.fn.stdpath 'config'` for config-only modules
  (search_highlight, keymaps) — no external dependency needed

## LSP Servers (managed by Mason)

Configured in `init.lua` under the `servers` table:
- gopls, pyright, angularls, bashls, dockerls, docker_compose_language_service
- groovyls, jsonls, marksman, terraformls, ts_ls, yamlls, lua_ls, taplo
- jdtls (managed by nvim-java, not in this table)

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
