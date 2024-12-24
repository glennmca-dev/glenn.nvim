local map = vim.keymap.set
local builtin = require 'fzf-lua'

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
  map('n', '<leader>fw', '<cmd>FzfLua live_grep<CR>', { desc = 'fzf live grep' }),
  map('n', '<leader>fb', '<cmd>FzfLua buffers<CR>', { desc = 'fzf find buffers' }),
  map('n', '<leader>ff', '<cmd>FzfLua files<cr>', { desc = 'fzf find files' }),
  map('n', '<leader>fz', '<cmd>FzfLua current_buffer_fuzzy_find<CR>', { desc = 'fzf find in current buffer' }),
  map('n', '<leader>fa', '<cmd>FzfLua files follow=true no_ignore=true hidden=true<CR>', { desc = 'fzf find all files' }),
  map('n', '<leader>sc', '<cmd>FzfLua colorschemes<CR>', { desc = 'fzf [S]earch installed [C]olourschemes' }),
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
  map('n', '<leader>x', function()
    local bufnr = vim.api.nvim_get_current_buf() -- Get current buffer number
    vim.cmd('bdelete!' .. bufnr)
  end, { noremap = true, silent = true }),
  map('n', '<Tab>', '<cmd>BufferLineCycleNext<CR>', { noremap = true, silent = true }),
  map('n', '<S-Tab>', '<cmd>BufferLineCyclePrev<CR>', { noremap = true, silent = true }),

  -- FZF lua
  -- See `:help telescope.builtin`
  vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' }),
  vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' }),
  vim.keymap.set('n', '<leader>sf', builtin.files, { desc = '[S]earch [F]iles' }),
  vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' }),
  vim.keymap.set('n', '<leader>sw', builtin.grep_cword, { desc = '[S]earch current [W]ord' }),
  vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' }),
  vim.keymap.set('n', '<leader>sd', builtin.diagnostics_document, { desc = '[S]earch [D]iagnostics' }),
  vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' }),
  vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' }),
  vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' }),

  -- Slightly advanced example of overriding default behavior and theme
  -- vim.keymap.set('n', '<leader>/', function()
  --   -- You can pass additional configuration to Telescope to change the theme, layout, etc.
  --   builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
  --     winblend = 10,
  --     previewer = false,
  --   })
  -- end, { desc = '[/] Fuzzily search in current buffer' })

  -- It's also possible to pass additional configuration options.
  --  See `:help telescope.builtin.live_grep()` for information about particular keys
  --     vim.keymap.set('n', '<leader>s/', function()
  --       builtin.live_grep {
  --         grep_open_files = true,
  --         prompt_title = 'Live Grep in Open Files',
  --       }
  --     end, { desc = '[S]earch [/] in Open Files' })
  --
  --     -- Shortcut for searching your Neovim configuration files
  --     vim.keymap.set('n', '<leader>sn', function()
  --       builtin.find_files { cwd = vim.fn.stdpath 'config' }
  --     end, { desc = '[S]earch [N]eovim files' })
}
