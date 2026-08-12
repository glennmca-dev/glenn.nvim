-- nvim-tree: Project file tree (floating window, toggled with <C-n>)
-- NOTE: oil.nvim handles directory editing (vim .) — nvim-tree is for project navigation

local HEIGHT_RATIO = 0.8
local WIDTH_RATIO = 0.5

return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  cmd = { 'NvimTreeToggle', 'NvimTreeFocus', 'NvimTreeFindFile', 'NvimTreeCollapse' },
  keys = {
    { '<C-n>', '<cmd>NvimTreeToggle<CR>', desc = 'nvimtree toggle window' },
    { '<leader>e', '<cmd>NvimTreeFocus<CR>', desc = 'nvimtree focus window' },
  },
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    -- Disable netrw (required by nvim-tree, oil takes over directory browsing)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

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
        full_name = true,
        root_folder_label = ':t',
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
    }
  end,
}
