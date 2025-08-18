local HEIGHT_RATIO = 0.8 -- You can change this
local WIDTH_RATIO = 0.5 -- You can change this too
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('nvim-tree').setup {
      filters = {
        custom = { '^.git$', '^.github$', 'node_modules', '.DS_Store' },
        dotfiles = false,
        git_ignored = false,
      },
      live_filter = {
        prefix = '[FILTER] ',
        always_show_folders = true,
      },
      renderer = {
        indent_width = 2,
        group_empty = true,
        indent_markers = { enable = true },
        highlight_opened_files = 'name',
        highlight_git = true,
        full_name = true, -- Show full file names instead of truncated
        root_folder_label = ':t', -- Show only directory name, not full path
        icons = {
          git_placement = 'signcolumn',
          show = {
            git = true,
            folder = true,
            file = true,
            folder_arrow = true,
          },
        },
      },
      modified = { enable = true, show_on_dirs = true, show_on_open_dirs = true },
      hijack_cursor = true,
      disable_netrw = true,
      hijack_netrw = true,
      respect_buf_cwd = true,
      sync_root_with_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true,
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
      },
      git = {
        enable = true,
        show_on_dirs = true,
        timeout = 400,
      },
      filesystem_watchers = {
        enable = true,
        debounce_delay = 50,
      },
      sort_by = 'case_sensitive',
      actions = {
        open_file = {
          quit_on_open = true,
          window_picker = {
            chars = '123456789',
          },
        },
      },
      view = {
        relativenumber = true,
        float = {
          enable = true,
          quit_on_focus_loss = true,
          open_win_config = function()
            local screen_w = vim.opt.columns:get()
            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
            local window_w = screen_w * WIDTH_RATIO
            local window_h = screen_h * HEIGHT_RATIO
            local window_w_int = math.floor(window_w)
            local window_h_int = math.floor(window_h)
            local center_x = (screen_w - window_w) / 2
            local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
            return {
              border = 'rounded',
              relative = 'editor',
              row = center_y,
              col = center_x,
              width = window_w_int,
              height = window_h_int,
            }
          end,
        },
        width = function()
          return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
        end,
      },
      -- filters = {
      --   custom = { "^.git$" },
      -- },
      -- renderer = {
      --   indent_width = 1,
      -- },
      -- create_in_closed_folder = true,
      -- hijack_cursor = true,
      -- open_on_setup = true,
      -- open_on_setup_file = true,
      -- focus_empty_on_setup = true,
      -- sync_root_with_cwd = true,
      -- view = {
      --   adaptive_size = false,
      --   mappings = {
      --     list = {
      --       { key = { '<2-RightMouse>', '<C-]>' }, action = '' }, -- cd
      --       { key = '<C-v>', action = '' }, -- vsplit
      --       { key = '<C-x>', action = '' }, -- split
      --       { key = '<C-t>', action = '' }, -- tabnew
      --       { key = '<BS>', action = '' }, -- close_node
      --       { key = '<Tab>', action = '' }, -- preview
      --       { key = 'D', action = '' }, -- trash
      --       { key = '[e', action = '' }, -- prev_diag_item
      --       { key = ']e', action = '' }, -- next_diag_item
      --       { key = '[c', action = '' }, -- prev_git_item
      --       { key = ']c', action = '' }, -- next_git_item
      --       { key = '-', action = '' }, -- dir_up
      --       { key = 's', action = '' }, -- system_open
      --       { key = 'W', action = '' }, -- collapse_all
      --       { key = 'g?', action = '' }, -- toggle_help
      --
      --       { key = 'd', action = 'cd' }, -- remove
      --       { key = 'x', action = 'remove' }, -- cut
      --
      --       { key = 't', action = 'cut' },
      --       { key = '<Space>p', action = 'prev_diag_item' },
      --       { key = '<Space>.', action = 'next_diag_item' },
      --       { key = '<Space>k', action = 'prev_git_item' },
      --       { key = '<Space>j', action = 'next_git_item' },
      --       { key = 'u', action = 'dir_up' },
      --       { key = "'", action = 'close_node' },
      --       { key = '"', action = 'collapse_all' },
      --       { key = '?', action = 'toggle_help' },
      --     },
      --   },
      -- },
      -- renderer = {
      --   full_name = true,
      --   group_empty = true,
      --   special_files = {},
      --   symlink_destination = false,
      --   indent_markers = {
      --     enable = true,
      --   },
      --   icons = {
      --     git_placement = 'signcolumn',
      --     show = {
      --       file = true,
      --       folder = false,
      --       folder_arrow = false,
      --       git = true,
      --     },
      --   },
      -- },
      -- update_focused_file = {
      --   enable = true,
      --   update_root = true,
      --   ignore_list = { 'help' },
      -- },
      -- diagnostics = {
      --   enable = true,
      --   show_on_dirs = true,
      -- },
      -- filters = {
      --   custom = {
      --     '^.git$',
      --   },
      -- },
      -- actions = {
      --   change_dir = {
      --     enable = false,
      --     restrict_above_cwd = true,
      --   },
      --   open_file = {
      --     resize_window = true,
      --     window_picker = {
      --       chars = 'aoeui',
      --     },
      --   },
      --   remove_file = {
      --     close_window = false,
      --   },
      -- },
      -- log = {
      --   enable = false,
      --   truncate = true,
      --   types = {
      --     all = false,
      --     config = false,
      --     copy_paste = false,
      --     diagnostics = false,
      --     git = false,
      --     profile = false,
      --     watcher = false,
      --   },
      -- },
    }
  end,
}
