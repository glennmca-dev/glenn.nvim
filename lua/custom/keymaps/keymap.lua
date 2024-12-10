local map = vim.keymap.set
return {

  -- map('n', '<leader>e', '<Cmd>NvimTreeFocus<CR>', { desc = 'Nvim-Tree Focus' })
  -- map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
  -- map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
  -- map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
  -- map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

  -- map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

  map('n', '<C-s>', '<cmd>w<CR>', { desc = 'general save file' }),
  map('n', '<C-c>', '<cmd>%y+<CR>', { desc = 'general copy whole file' }),

  map('n', '<leader>n', '<cmd>set nu!<CR>', { desc = 'toggle line number' }),
  map('n', '<leader>rn', '<cmd>set rnu!<CR>', { desc = 'toggle relative number' }),
  -- map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" })

  -- map("n", "<leader>fm", function()
  -- require("conform").format { lsp_fallback = true }
  -- end, { desc = "general format file" })

  -- global lsp mappings
  -- map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP diagnostic loclist" })

  -- tabufline
  -- map("n", "<leader>b", "<cmd>enew<CR>", { desc = "buffer new" })

  -- map("n", "<tab>", function()
  -- require("nvchad.tabufline").next()
  -- end, { desc = "buffer goto next" })

  -- map("n", "<S-tab>", function()
  -- require("nvchad.tabufline").prev()
  -- end, { desc = "buffer goto prev" })

  -- map("n", "<leader>x", function()
  -- require("nvchad.tabufline").close_buffer()
  -- end, { desc = "buffer close" })

  -- Comment
  map('n', '<leader>/', 'gcc', { desc = 'toggle comment', remap = true }),
  map('v', '<leader>/', 'gc', { desc = 'toggle comment', remap = true }),

  -- nvimtree
  map('n', '<C-n>', '<cmd>NvimTreeToggle<CR>', { desc = 'nvimtree toggle window' }),
  map('n', '<leader>e', '<cmd>NvimTreeFocus<CR>', { desc = 'nvimtree focus window' }),

  -- cmd line
  -- map('n', ':', '<cmd>FineCmdline<CR>', { noremap = true }), -- Leaving this out so the OG command still works
  map('n', ';', '<cmd>FineCmdline<CR>', { noremap = true }),

  -- telescope
  map('n', '<leader>fw', '<cmd>Telescope live_grep<CR>', { desc = 'telescope live grep' }),
  map('n', '<leader>fb', '<cmd>Telescope buffers<CR>', { desc = 'telescope find buffers' }),
  map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'telescope find files' }),
  map('n', '<leader>fz', '<cmd>Telescope current_buffer_fuzzy_find<CR>', { desc = 'telescope find in current buffer' }),
  map('n', '<leader>fa', '<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>', { desc = 'telescope find all files' }),
  -- map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
  -- map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
  -- map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
  -- map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
  -- map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
  -- map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })

  -- terminal
  -- map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

  -- new terminals
  -- map("n", "<leader>h", function()
  --   require("nvchad.term").new { pos = "sp" }
  -- end, { desc = "terminal new horizontal term" })
  --
  -- map("n", "<leader>v", function()
  --   require("nvchad.term").new { pos = "vsp" }
  -- end, { desc = "terminal new vertical term" })
  --
  -- toggleable
  -- map({ "n", "t" }, "<A-v>", function()
  --   require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
  -- end, { desc = "terminal toggleable vertical term" })
  --
  -- map({ "n", "t" }, "<A-h>", function()
  --   require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
  -- end, { desc = "terminal toggleable horizontal term" })
  --
  map({ 'n', 't' }, '<A-i>', '<cmd>ToggleTerm<CR>', { desc = 'Open/Toggle floating terminal' }),
  --
  -- whichkey
  -- map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

  -- map("n", "<leader>wk", function()
  --   vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
  -- end, { desc = "whichkey query lookup" })

  -- bufferline
  map('n', '<leader>x', '<cmd>lua delete_current_buffer()<CR>', { noremap = true, silent = true }),
  map('n', '<leader>x', function()
    local bufnr = vim.api.nvim_get_current_buf() -- Get current buffer number
    vim.cmd('bdelete!' .. bufnr)
  end, { noremap = true, silent = true }),
}
