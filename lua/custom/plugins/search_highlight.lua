-- Custom search highlighting - bright lavender colors
-- Virtual plugin spec: the dir points to this config's own directory
-- so lazy.nvim loads it without pulling any external dependency
return {
  dir = vim.fn.stdpath 'config',
  name = 'search-highlight-overrides',
  lazy = false,
  priority = 9999, -- run after colorscheme loads
  config = function()
    local highlight_group = vim.api.nvim_create_augroup('BrightSearchHighlight', { clear = true })

    vim.api.nvim_create_autocmd('ColorScheme', {
      group = highlight_group,
      callback = function()
        vim.api.nvim_set_hl(0, 'Search', { bg = '#bb9af7', fg = '#1a1b26', bold = true })
        vim.api.nvim_set_hl(0, 'IncSearch', { bg = '#d0a9ff', fg = '#1a1b26', bold = true })
        vim.api.nvim_set_hl(0, 'CurSearch', { bg = '#c4a7e7', fg = '#1a1b26', bold = true })
      end,
    })

    -- Apply immediately for current colorscheme
    vim.api.nvim_set_hl(0, 'Search', { bg = '#bb9af7', fg = '#1a1b26', bold = true })
    vim.api.nvim_set_hl(0, 'IncSearch', { bg = '#d0a9ff', fg = '#1a1b26', bold = true })
    vim.api.nvim_set_hl(0, 'CurSearch', { bg = '#c4a7e7', fg = '#1a1b26', bold = true })
  end,
}
