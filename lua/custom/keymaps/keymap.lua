-- Custom keymaps
-- NOTE: Uses Colemak-DH layout - bindings may seem unusual for QWERTY users
return {
  dir = vim.fn.stdpath 'config',
  name = 'custom-keymaps',
  lazy = false,
  init = function()
    local map = vim.keymap.set

    -- Basic operations
    map('n', '<C-s>', '<cmd>w<CR>', { desc = 'Save file' })
    map('n', '<C-c>', '<cmd>%y+<CR>', { desc = 'Copy whole file' })

    -- Comment (uses mini.comment or similar gc operator)
    map('n', '<leader>/', 'gcc', { desc = 'Toggle comment', remap = true })
    map('v', '<leader>/', 'gc', { desc = 'Toggle comment', remap = true })

    -- nvim-tree
    map('n', '<C-n>', '<cmd>NvimTreeToggle<CR>', { desc = 'nvimtree toggle window' })
    map('n', '<leader>e', '<cmd>NvimTreeFocus<CR>', { desc = 'nvimtree focus window' })

    -- Fine command line
    map('n', ';', '<cmd>FineCmdline<CR>', { noremap = true, desc = 'Command line' })

    -- Telescope shortcuts (leader-f prefix)
    map('n', '<leader>fw', '<cmd>Telescope live_grep<CR>', { desc = 'Telescope live grep' })
    map('n', '<leader>fb', '<cmd>Telescope buffers<CR>', { desc = 'Telescope find buffers' })
    map('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { desc = 'Telescope find files' })
    map('n', '<leader>f.', '<cmd>Telescope current_buffer_fuzzy_find<CR>', { desc = 'Telescope current buffer search' })
    map('n', '<leader>fa', '<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>', { desc = 'Telescope find all files' })
    map('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', { desc = 'Telescope help' })
    map('n', '<leader>ma', '<cmd>Telescope marks<CR>', { desc = 'Telescope marks' })

    -- Window navigation (Colemak-DH: Option+w to cycle)
    map('n', '<A-w>', '<C-w>w', { desc = 'Cycle windows (Option+w)', noremap = true })

    -- Bufferline
    map('n', '<leader>x', function()
      local bufnr = vim.api.nvim_get_current_buf()
      vim.cmd('bdelete! ' .. bufnr)
    end, { noremap = true, silent = true, desc = 'Delete buffer' })
    map('n', '<Tab>', '<cmd>BufferLineCycleNext<CR>', { noremap = true, silent = true, desc = 'Next buffer' })
    map('n', '<S-Tab>', '<cmd>BufferLineCyclePrev<CR>', { noremap = true, silent = true, desc = 'Prev buffer' })

    -- Diagnostics
    map('n', '<leader>cd', function()
      vim.diagnostic.open_float(nil, { scope = 'line', focus = false, border = 'rounded' })
    end, { desc = '[C]ode [D]iagnostics (line)' })
  end,
}
