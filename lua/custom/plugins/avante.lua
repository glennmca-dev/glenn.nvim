return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  version = false, -- Never set this value to "*"! Never!
  opts = {
    provider = 'copilot',
    copilot = {
      model = 'claude-3.7-sonnet',
      temperature = 0.3, -- More balanced temperature for accuracy while maintaining some creativity
      max_tokens = 200000, -- Increased token limit for larger context window
      stream = true, -- Keep streaming enabled for real-time responses
      top_p = 0.9, -- Slightly reduced to favor more precise outputs
      top_k = 40, -- Adding top_k to focus on more likely tokens
      context_window = 150000, -- Explicitly set a large context window
      timeout = 60000, -- Increased timeout for complex reasoning tasks (ms)
      reasoning_mode = 'deep', -- Encourage more thorough analysis
      max_completion_tokens = 64000, -- Control output length while allowing for detailed responses
    },
    -- Enable features that help with code accuracy
    enable_file_cache = true, -- Cache previously processed files for faster context building
    file_cache_size_mb = 500, -- Increased cache size for larger projects
    -- Auto-refresh context on file changes
    watch_files = true,
    -- More aggressive context strategy to improve coding accuracy
    context_strategy = 'comprehensive',
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
    'ibhagwan/fzf-lua', -- for file_selector provider fzf
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
