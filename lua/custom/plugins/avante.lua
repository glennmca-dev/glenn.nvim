return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  version = false, -- Never set this value to "*"! Never!
  opts = {
    providers = {
      copilot = {
        model = 'claude-sonnet-4',
        stream = true, -- Streaming is fine for UX, doesn't affect token usage
        top_p = 0.8, -- Lowered for more focused completions
        top_k = 20, -- Lowered for more focused completions
        context_window = 4096, -- Dramatically reduced to limit context sent per request
        timeout = 30000, -- Lowered to default, adjust as needed
        reasoning_mode = 'deep',
        max_completion_tokens = 1024, -- Lowered to cap output length
        extra_request_body = {
          temperature = 0.2, -- Lowered for more deterministic completions
          max_tokens = 2048, -- Lowered to cap Claude API output
        },
      },
    },
    provider = 'copilot',

    -- Enable features that help with code accuracy
    enable_file_cache = true, -- Caching is fine
    file_cache_size_mb = 50, -- Lowered cache size to reduce context scope
    watch_files = false, -- Disable to avoid unnecessary context refreshes
    context_strategy = 'default', -- Less aggressive, reduces context sent

    -- UI sizes for Avante windows
    windows = {
      -- Controls the height of the prompt input area at the bottom of the Avante sidebar
      input = {
        height = 16, -- increase from default (6) to open with more lines
      },
      -- You can also control the sidebar width/height if desired:
      -- width = 30,  -- percentage in vertical layout
      -- height = 30, -- percentage in horizontal layout
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = 'make',
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'stevearc/dressing.nvim',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    --- The below dependencies are optional,
    'echasnovski/mini.pick', -- for file_selector provider mini.pick
    'nvim-telescope/telescope.nvim', -- for file_selector provider telescope
    'hrsh7th/nvim-cmp', -- autocompletion for avante commands and mentions
    -- 'ibhagwan/fzf-lua', -- for file_selector provider fzf
    'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
    'zbirenbaum/copilot.lua', -- for providers='copilot'
    {
      -- support for image pasting
      'HakonHarnes/img-clip.nvim',
      event = 'VeryLazy',
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { 'markdown', 'Avante' },
      },
      ft = { 'markdown', 'Avante' },
    },
  },
}
