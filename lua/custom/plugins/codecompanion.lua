-- CodeCompanion.nvim - AI coding assistant with switchable providers
-- Supports: Kiro (ACP), Claude (Anthropic), Copilot, OpenAI, Ollama, and more
--
-- CURRENT DEFAULT: Kiro via ACP (uses kiro-cli acp)
-- FUTURE: Switch to Claude by changing interactions.chat.adapter to "anthropic"
--          and setting ANTHROPIC_API_KEY env var
--
-- Usage:
--   :CodeCompanionChat              - Open chat buffer (uses Kiro by default)
--   :CodeCompanionChat Toggle       - Toggle chat buffer
--   :CodeCompanionChat adapter=anthropic - Switch to Claude (needs API key)
--   :CodeCompanion <prompt>         - Inline code generation
--   :CodeCompanionActions           - Open action palette
--   :CodeCompanionCLI               - CLI interaction (Kiro terminal)
--   :CodeCompanionCLI agent=kiro    - Explicitly use Kiro CLI
--
-- Prerequisites:
--   - kiro-cli installed and on PATH (https://kiro.dev/docs/cli/)
--   - Logged in via: kiro-cli (follow prompts on first run)
--
-- To switch to Claude later:
--   1. Set ANTHROPIC_API_KEY in your shell
--   2. Change interactions.chat.adapter below from "kiro" to "anthropic"

return {
  'olimorris/codecompanion.nvim',
  version = '^19.0.0',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  cmd = { 'CodeCompanion', 'CodeCompanionChat', 'CodeCompanionActions', 'CodeCompanionCmd', 'CodeCompanionCLI' },
  keys = {
    { '<leader>ai', '<cmd>CodeCompanionChat Toggle<cr>', mode = { 'n', 'v' }, desc = 'AI Chat Toggle' },
    { '<leader>aa', '<cmd>CodeCompanionActions<cr>', mode = { 'n', 'v' }, desc = 'AI Actions' },
    { '<leader>ap', '<cmd>CodeCompanion<cr>', mode = 'v', desc = 'AI Inline Prompt' },
    { 'ga', '<cmd>CodeCompanionChat Add<cr>', mode = 'v', desc = 'AI Add to Chat' },
  },
  opts = {
    -- Interactions: which adapter/agent to use for each mode
    interactions = {
      -- Chat buffer uses Kiro via ACP (built-in adapter, runs kiro-cli acp)
      chat = {
        adapter = 'kiro',
      },
      -- Inline also uses Kiro
      -- NOTE: When you get Claude, change this to "anthropic" for faster inline responses
      inline = {
        adapter = 'kiro',
      },
      -- CLI interaction (terminal-based, available if needed)
      cli = {
        agent = 'kiro',
        agents = {
          kiro = {
            cmd = 'kiro-cli',
            args = { 'chat' },
            description = 'Kiro CLI',
            provider = 'terminal',
          },
        },
      },
    },
    display = {
      action_palette = {
        provider = 'telescope',
      },
      chat = {
        window = {
          layout = 'vertical',
          width = 0.4,
        },
      },
    },
    opts = {
      log_level = 'ERROR',
    },
  },
}
