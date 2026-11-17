-- Markdown display: pretty in-buffer rendering (headers, lists, tables,
-- checkboxes, code block borders), plus Mermaid/PlantUML/D2 fenced code
-- blocks rendered as real images via image.nvim (Kitty graphics protocol).
--
-- LSP (marksman) and formatting (prettierd/prettier) for markdown are
-- configured in init.lua; this file only covers presentation.
--
-- Diagram rendering needs `mmdc` (mermaid-cli), `plantuml`, or `d2` on PATH
-- depending on the diagram type actually used — install whichever you need.
return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      completions = { lsp = { enabled = true } },
    },
  },

  -- Image backend used by diagram.nvim to display rendered diagrams inline.
  {
    '3rd/image.nvim',
    build = false, -- avoid building the `magick` rock from source; use the system luarocks install
    opts = {
      backend = 'kitty',
      max_width = 100,
      max_height = 30,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = true,
      window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs', '' },
    },
  },

  -- Renders ```mermaid / ```plantuml / ```d2 fenced blocks as images.
  {
    '3rd/diagram.nvim',
    ft = { 'markdown' },
    dependencies = { '3rd/image.nvim' },
    opts = function()
      return {
        integrations = {
          require('diagram.integrations.markdown'),
        },
        renderer_options = {
          mermaid = {
            theme = 'dark',
            background = 'transparent',
            scale = 2,
          },
        },
      }
    end,
  },
}
