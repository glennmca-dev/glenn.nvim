return {
  {
    'nvim-lua/plenary.nvim',
    lazy = false,
    init = function()
      local map = vim.keymap.set

      -- Basic
      map('n', '<C-s>', '<cmd>w<CR>', { desc = 'save file' })
      map('n', '<C-c>', '<cmd>%y+<CR>', { desc = 'copy whole file' })
      -- Use Snacks toggles: <leader>ul (line number) and <leader>uL (relative number)

      -- Comment (requires a comment plugin such as mini.comment or Comment.nvim)
      map('n', '<leader>/', 'gcc', { desc = 'toggle comment', remap = true })
      map('v', '<leader>/', 'gc', { desc = 'toggle comment', remap = true })

      -- nvim-tree
      map('n', '<C-n>', '<cmd>NvimTreeToggle<CR>', { desc = 'nvimtree toggle window' })
      map('n', '<leader>e', '<cmd>NvimTreeFocus<CR>', { desc = 'nvimtree focus window' })

      -- cmd line (fine-cmdline)
      map('n', ';', '<cmd>FineCmdline<CR>', { noremap = true, desc = 'Command line' })

      -- telescope
      map('n', '<leader>fw', '<cmd>Telescope live_grep<CR>', { desc = 'telescope live grep' })
      map('n', '<leader>fb', '<cmd>Telescope buffers<CR>', { desc = 'telescope find buffers' })
      map('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { desc = 'telescope find files' })
      map('n', '<leader>f.', '<cmd>Telescope current_buffer_fuzzy_find<CR>', { desc = 'telescope current buffer search' })
      map('n', '<leader>fa', '<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>', { desc = 'telescope find all files' })
      map('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', { desc = 'telescope help' })
      map('n', '<leader>ma', '<cmd>Telescope marks<CR>', { desc = 'telescope marks' })

      -- Window navigation
      map('n', '<A-w>', '<C-w>w', { desc = 'cycle windows (Option+w)', noremap = true })

      -- Terminal
      map({ 'n', 't' }, '<A-i>', '<cmd>ToggleTerm<CR>', { desc = 'Toggle floating terminal' })
      map({ 'n', 't' }, '<A-h>', '<cmd>ToggleTerm size=15 direction=horizontal<CR>', { desc = 'Toggle horizontal terminal' })

      -- Bufferline
      map('n', '<leader>x', function()
        local bufnr = vim.api.nvim_get_current_buf()
        vim.cmd('bdelete! ' .. bufnr)
      end, { noremap = true, silent = true, desc = 'delete buffer' })
      map('n', '<Tab>', '<cmd>BufferLineCycleNext<CR>', { noremap = true, silent = true, desc = 'next buffer' })
      map('n', '<S-Tab>', '<cmd>BufferLineCyclePrev<CR>', { noremap = true, silent = true, desc = 'prev buffer' })
    end,
  },
}
