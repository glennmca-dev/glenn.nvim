return {
  'ibhagwan/fzf-lua',
  -- optional for icon support
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'VimEnter',
  opts = {
    fzf_opts = { ['--wrap'] = true },
    preview = 'bat',
    previewers = {
      bat = {
        theme = 'Catppuccin Mocha',
        cmd = 'batcat',
      },
      -- builtin = {
      --   syntax_limit_b = -102400, -- 100KB limit on highlighting files
      -- },
    },
    grep = {
      rg_glob = true,
      -- first returned string is the new search query
      -- second returned string are (optional) additional rg flags
      -- @return string, string?
      rg_glob_fn = function(query, opts)
        local regex, flags = query:match '^(.-)%s%-%-(.*)$'
        -- If no separator is detected will return the original query
        return (regex or query), flags
      end,
    },
    winopts = {
      backdrop = 90,
      preview = {
        wrap = 'wrap',
      },
    },
    defaults = {
      git_icons = false,
      file_icons = false,
      color_icons = false,
      formatter = 'path.filename_first',
    },
  },
}
