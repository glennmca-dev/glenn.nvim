-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
--
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
  {
    'nvim-java/nvim-java',
    lazy = true,
  },
  {
    'VonHeikemen/fine-cmdline.nvim',
    dependencies = {
      {
        'MunifTanjim/nui.nvim',
        lazy = true,
      },
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
  -- {
  --   'goolord/alpha-nvim',
  --   lazy = true,
  --   event = 'VimEnter',
  --   config = function()
  --     require 'custom.settings.alpha'
  --   end,
  --   cmd = 'Alpha',
  -- }, -- Splash Screen
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    opts = {},
  }, -- better ui
  {
    'akinsho/bufferline.nvim',
    version = 'v4.9.0',
    dependencies = 'nvim-tree/nvim-web-devicons',
    lazy = false,
    opts = {
      -- color_icons = true,
      -- hover = {
      -- enabled = true,
      -- delay = 200,
      -- reveal = { 'close' },
      -- },
    },
  },
  {
    'akinsho/toggleterm.nvim',
    version = 'latest',
    opts = {
      direction = 'float',
      size = 10,
      float_opts = {
        -- The border key is *almost* the same as 'nvim_open_win'
        -- see :h nvim_open_win for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        border = 'curved',
        -- like `size`, width, height, row, and col can be a number or function which is passed the current terminal
        width = 200,
        height = 40,
        winblend = 4,
        title_pos = 'center',
      },
    },
  },
  -- {
  -- 'tiagovla/scope.nvim',
  -- opts = {},
  -- },
  { 'github/copilot.vim' },
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
          wo = { wrap = true }, -- Wrap notifications
        },
      },
    },
    keys = {
      {
        '<leader>.',
        function()
          Snacks.scratch()
        end,
        desc = 'Toggle Scratch Buffer',
      },
      {
        '<leader>S',
        function()
          Snacks.scratch.select()
        end,
        desc = 'Select Scratch Buffer',
      },
      {
        '<leader>n',
        function()
          Snacks.notifier.show_history()
        end,
        desc = 'Notification History',
      },
      {
        '<leader>bd',
        function()
          Snacks.bufdelete()
        end,
        desc = 'Delete Buffer',
      },
      {
        '<leader>cR',
        function()
          Snacks.rename.rename_file()
        end,
        desc = 'Rename File',
      },
      {
        '<leader>gB',
        function()
          Snacks.gitbrowse()
        end,
        desc = 'Git Browse',
      },
      {
        '<leader>gb',
        function()
          Snacks.git.blame_line()
        end,
        desc = 'Git Blame Line',
      },
      {
        '<leader>gf',
        function()
          Snacks.lazygit.log_file()
        end,
        desc = 'Lazygit Current File History',
      },
      {
        '<leader>gg',
        function()
          Snacks.lazygit()
        end,
        desc = 'Lazygit',
      },
      {
        '<leader>gl',
        function()
          Snacks.lazygit.log()
        end,
        desc = 'Lazygit Log (cwd)',
      },
      {
        '<leader>un',
        function()
          Snacks.notifier.hide()
        end,
        desc = 'Dismiss All Notifications',
      },
      {
        '<c-/>',
        function()
          Snacks.terminal()
        end,
        desc = 'Toggle Terminal',
      },
      {
        '<c-_>',
        function()
          Snacks.terminal()
        end,
        desc = 'which_key_ignore',
      },
      {
        ']]',
        function()
          Snacks.words.jump(vim.v.count1)
        end,
        desc = 'Next Reference',
        mode = { 'n', 't' },
      },
      {
        '[[',
        function()
          Snacks.words.jump(-vim.v.count1)
        end,
        desc = 'Prev Reference',
        mode = { 'n', 't' },
      },
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
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>us'
          Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>uw'
          Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>uL'
          Snacks.toggle.diagnostics():map '<leader>ud'
          Snacks.toggle.line_number():map '<leader>ul'
          Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map '<leader>uc'
          Snacks.toggle.treesitter():map '<leader>uT'
          Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map '<leader>ub'
          Snacks.toggle.inlay_hints():map '<leader>uh'
        end,
      })
    end,
  },
}
