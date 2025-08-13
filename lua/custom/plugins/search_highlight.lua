-- Custom search highlighting settings
return {
  -- This is an empty plugin spec that just sets up an autocmd
  -- to brighten search highlights with lavender colors
  'nvim-lua/plenary.nvim', -- Use any plugin that's guaranteed to be loaded
  priority = 9999, -- Make sure it's loaded last
  config = function()
    -- Create an autocmd group for our search highlight customizations
    local highlight_group = vim.api.nvim_create_augroup('BrightSearchHighlight', { clear = true })

    -- Set up autocmd to run after any colorscheme change
    vim.api.nvim_create_autocmd('ColorScheme', {
      group = highlight_group,
      callback = function()
        -- Define bright lavender colors for search highlighting
        vim.api.nvim_set_hl(0, 'Search', { bg = '#bb9af7', fg = '#1a1b26', bold = true })
        vim.api.nvim_set_hl(0, 'IncSearch', { bg = '#d0a9ff', fg = '#1a1b26', bold = true })
        vim.api.nvim_set_hl(0, 'CurSearch', { bg = '#c4a7e7', fg = '#1a1b26', bold = true })
      end,
    })

    -- Run immediately to apply to current colorscheme
    vim.cmd 'doautocmd ColorScheme'
  end,
}
