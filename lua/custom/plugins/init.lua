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
