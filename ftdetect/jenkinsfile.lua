-- Filetype detection for Jenkinsfiles
-- Set filetype to groovy for Jenkinsfile patterns

-- Detect files named "Jenkinsfile" (case-sensitive)
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { 'Jenkinsfile' },
  callback = function()
    vim.bo.filetype = 'groovy'
  end,
})

-- Detect files with .Jenkinsfile extension
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.Jenkinsfile' },
  callback = function()
    vim.bo.filetype = 'groovy'
  end,
})
