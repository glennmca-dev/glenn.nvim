-- Custom plugins configuration
-- See individual files in this directory for: oil, nvim-tree, xml_change_version

local dash_header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ 
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ 
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ 
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ 
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ 
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ 
███████╗ ██████╗     ██╗████████╗    ██╗███████╗   
██╔════╝██╔═══██╗    ██║╚══██╔══╝    ██║██╔════╝   
███████╗██║   ██║    ██║   ██║       ██║███████╗   
╚════██║██║   ██║    ██║   ██║       ██║╚════██║   
███████║╚██████╔╝    ██║   ██║       ██║███████║██╗
╚══════╝ ╚═════╝     ╚═╝   ╚═╝       ╚═╝╚══════╝╚═╝]]

return {
  -- Java development (nvim-java)
  {
    'nvim-java/nvim-java',
    ft = 'java',
    dependencies = {
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
    },
    config = function()
      -- jdtls 1.54 must itself run on Java 21-25, even when the *projects* you
      -- edit target Java 17. `java` on PATH here is mise's global Java 17, so
      -- jdtls refused to start ("requires Java 21 <= java >= 25, found 17").
      --
      -- Point nvim-java at a Java 21+ install for the language server only.
      -- This does not change the JDK your projects compile against — jdtls
      -- detects that per-project from pom.xml/gradle.
      --
      -- nvim-java's own `jdk.auto_install` is not a fallback: it downloads from
      -- a download.oracle.com URL that now returns HTTP 403.
      -- Scan mise's JDK installs once, returning { [major] = java_home }.
      -- Keeps the newest patch release per major version.
      local function mise_jdks()
        -- NOTE: expand the `~` separately — passing a path that still contains
        -- `*` through expand() collapses it to a single match before glob runs.
        local dirs = vim.fn.glob(vim.fn.expand '~' .. '/.local/share/mise/installs/java/*', false, true)
        local by_major = {}
        for _, dir in ipairs(dirs) do
          -- mise lays JDKs out as either <dir>/bin or <dir>/Contents/Home/bin.
          -- Skip symlinks (e.g. `zulu-17` -> `zulu-17.54.21`) to avoid duplicates.
          local home = vim.fn.isdirectory(dir .. '/Contents/Home/bin') == 1 and dir .. '/Contents/Home' or dir
          if vim.fn.executable(home .. '/bin/java') == 1 and vim.fn.getftype(dir) ~= 'link' then
            local out = vim.fn.system { home .. '/bin/java', '-version' }
            local major = tonumber(out:match 'version "1%.(%d+)') or tonumber(out:match 'version "(%d+)')
            if major then
              by_major[major] = by_major[major] or home
            end
          end
        end
        return by_major
      end

      local jdks = mise_jdks()

      -- jdtls itself needs Java 21-25 to run. Pick the newest match.
      local jdtls_jdk
      for _, major in ipairs { 25, 24, 23, 22, 21 } do
        if jdks[major] then
          jdtls_jdk = jdks[major]
          break
        end
      end
      if not jdtls_jdk then
        vim.notify('nvim-java: no Java 21-25 install found; jdtls will not start.\nInstall one with `mise install java@25`.', vim.log.levels.WARN)
      end

      -- Advertise every mise JDK to jdtls as an available runtime. This is what
      -- lets a project compile against its own Java level (from pom.xml/gradle,
      -- or a `mise.toml`-pinned version) rather than the JVM jdtls runs on.
      -- Without this, `java.configuration.runtimes` is empty and jdtls falls
      -- back to its own runtime for anything it can't infer from the build file.
      local runtimes = {}
      for major, home in pairs(jdks) do
        -- jdtls expects the "JavaSE-<n>" execution-environment names (JavaSE-1.8 for 8)
        local name = major <= 8 and ('JavaSE-1.' .. major) or ('JavaSE-' .. major)
        table.insert(runtimes, { name = name, path = home })
      end
      table.sort(runtimes, function(a, b)
        return a.name < b.name
      end)

      require('java').setup {
        -- Lombok support (bundled with nvim-java).
        -- Version intentionally left unset: nvim-java pins the release matched
        -- to its jdtls version (1.18.42 for jdtls 1.54). The old hard-coded
        -- 1.18.40 predates Java 25 support and breaks annotation processing.
        lombok = {
          enable = true,
        },
        -- JDK used to *run* jdtls (see find_jdk21_plus above)
        jdk = {
          auto_install = false,
          path = jdtls_jdk,
        },
        -- Spring Boot tools for Spring projects
        spring_boot_tools = {
          enable = true,
        },
        -- Testing support (runs tests without full DAP)
        java_test = {
          enable = true,
        },
        -- Disable debug adapter (user doesn't debug)
        java_debug_adapter = {
          enable = false,
        },
      }

      -- Hand the runtime list to jdtls. Must come after java.setup() so it
      -- merges on top of the config nvim-java registers.
      if #runtimes > 0 then
        vim.lsp.config('jdtls', {
          settings = {
            java = {
              configuration = { runtimes = runtimes },
            },
          },
        })
      end

      -- Enable jdtls via the new vim.lsp.enable API (Neovim 0.11+)
      -- Falls back to lspconfig for older Neovim versions
      if vim.lsp.enable then
        vim.lsp.enable 'jdtls'
      else
        require('lspconfig').jdtls.setup {}
      end
    end,
  },

  -- Fine command line (floating command input)
  {
    'VonHeikemen/fine-cmdline.nvim',
    dependencies = {
      { 'MunifTanjim/nui.nvim', lazy = true },
    },
    opts = {
      cmdline = {
        prompt = '>_ ',
        smart_history = true,
      },
      popup = {
        position = {
          row = '50%',
          col = '50%',
        },
        border = {
          padding = { 1, 2 },
          style = 'rounded',
          text = {
            top = '< Neovim Command >',
            top_align = 'center',
          },
        },
        win_options = {
          winblend = 10,
        },
      },
    },
  },

  -- Better UI for vim.ui.select/input
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    opts = {},
  },

  -- Buffer tabs
  {
    'akinsho/bufferline.nvim',
    version = 'v4.*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    event = 'BufReadPost',
    opts = {},
  },

  -- Snacks.nvim (dashboard, notifications, lazygit, terminal, etc.)
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@diagnostic disable-next-line: undefined-doc-name
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      dashboard = {
        enabled = true,
        preset = {
          header = dash_header,
        },
      },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      lazygit = {
        git = {
          paging = {
            useConfig = true,
          },
        },
      },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      styles = {
        notification = {
          wo = { wrap = true },
        },
      },
    },
    keys = {
      { '<leader>.', function() Snacks.scratch() end, desc = 'Toggle Scratch Buffer' },
      { '<leader>S', function() Snacks.scratch.select() end, desc = 'Select Scratch Buffer' },
      { '<leader>n', function() Snacks.notifier.show_history() end, desc = 'Notification History' },
      { '<leader>bd', function() Snacks.bufdelete() end, desc = 'Delete Buffer' },
      { '<leader>cR', function() Snacks.rename.rename_file() end, desc = 'Rename File' },
      { '<leader>gB', function() Snacks.gitbrowse() end, desc = 'Git Browse' },
      { '<leader>gb', function() Snacks.git.blame_line() end, desc = 'Git Blame Line' },
      { '<leader>gf', function() Snacks.lazygit.log_file() end, desc = 'Lazygit Current File History' },
      { '<leader>gg', function() Snacks.lazygit() end, desc = 'Lazygit' },
      { '<leader>gl', function() Snacks.lazygit.log() end, desc = 'Lazygit Log (cwd)' },
      { '<leader>un', function() Snacks.notifier.hide() end, desc = 'Dismiss All Notifications' },
      { '<c-/>', function() Snacks.terminal() end, desc = 'Toggle Terminal' },
      { '<c-_>', function() Snacks.terminal() end, desc = 'which_key_ignore' },
      { ']]', function() Snacks.words.jump(vim.v.count1) end, desc = 'Next Reference', mode = { 'n', 't' } },
      { '[[', function() Snacks.words.jump(-vim.v.count1) end, desc = 'Prev Reference', mode = { 'n', 't' } },
      {
        '<leader>N',
        desc = 'Neovim News',
        function()
          Snacks.win {
            file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
            width = 0.6,
            height = 0.6,
            wo = {
              spell = false,
              wrap = false,
              signcolumn = 'yes',
              statuscolumn = ' ',
              conceallevel = 3,
            },
          }
        end,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
          -- Debug globals (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd

          -- Toggle mappings
          local t_spell = Snacks.toggle.option('spell', { name = 'Spelling' })
          vim.keymap.set('n', '<leader>us', function() t_spell:toggle() end, { desc = 'Toggle Spelling' })

          local t_wrap = Snacks.toggle.option('wrap', { name = 'Wrap' })
          vim.keymap.set('n', '<leader>uw', function() t_wrap:toggle() end, { desc = 'Toggle Wrap' })

          local t_rnu = Snacks.toggle.option('relativenumber', { name = 'Relative Number' })
          vim.keymap.set('n', '<leader>uL', function() t_rnu:toggle() end, { desc = 'Toggle Relative Number' })

          local t_diag = Snacks.toggle.diagnostics()
          vim.keymap.set('n', '<leader>ud', function() t_diag:toggle() end, { desc = 'Toggle Diagnostics' })

          local t_lnum = Snacks.toggle.line_number()
          vim.keymap.set('n', '<leader>ul', function() t_lnum:toggle() end, { desc = 'Toggle Line Number' })

          local t_conceal = Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
          vim.keymap.set('n', '<leader>uc', function() t_conceal:toggle() end, { desc = 'Toggle Conceal' })

          local t_ts = Snacks.toggle.treesitter()
          vim.keymap.set('n', '<leader>uT', function() t_ts:toggle() end, { desc = 'Toggle Treesitter' })

          local t_bg = Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' })
          vim.keymap.set('n', '<leader>ub', function() t_bg:toggle() end, { desc = 'Toggle Dark Background' })

          local t_inlay = Snacks.toggle.inlay_hints()
          vim.keymap.set('n', '<leader>uh', function() t_inlay:toggle() end, { desc = 'Toggle Inlay Hints' })
        end,
      })
    end,
  },
}
