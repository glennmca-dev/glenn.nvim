local alpha = require 'alpha'
local dashboard = require 'alpha.themes.dashboard'
local icons = {
  kinds = {
    new = {
      Text = '󰉿 ',
      Method = '󰆧 ',
      Function = '󰊕 ',
      Constructor = ' ',
      Field = '󰜢 ',
      Variable = ' ',
      Class = '󰠱 ',
      Interface = ' ',
      Module = ' ',
      Property = '󰜢 ',
      Unit = '󰑭 ',
      Value = '󰎠 ',
      Enum = ' ',
      Keyword = '󰌋 ',
      Snippet = ' ',
      Color = '󰏘 ',
      File = '󰈙 ',
      Reference = '󰈇 ',
      Folder = '󰉋 ',
      EnumMember = ' ',
      Constant = '󰏿 ',
      Struct = '󰙅 ',
      Event = ' ',
      Operator = '󰆕 ',
      TypeParameter = ' ',
    },

    kind_icons = {
      Array = ' ',
      Boolean = ' ',
      Text = ' ',
      Method = '󰆧 ',
      Function = '󰊕 ',
      Constructor = ' ',
      Field = '󰇽 ',
      Variable = '󰂡 ',
      Class = '󰠱 ',
      Interface = ' ',
      Module = ' ',
      Null = '󰟢 ',
      Property = '󰜢 ',
      Unit = ' ',
      Value = '󰎠 ',
      Enum = ' ',
      Key = ' ',
      Keyword = '󰌋 ',
      Snippet = ' ',
      Package = ' ',
      Color = '󰏘 ',
      File = '󰈙 ',
      Reference = ' ',
      Folder = '󰉋 ',
      EnumMember = ' ',
      Constant = '󰏿 ',
      Struct = ' ',
      Object = ' ',
      Event = ' ',
      Operator = '󰆕 ',
      TypeParameter = '󰅲 ',
    },

    codicons = {
      Text = ' ',
      Method = ' ',
      Function = ' ',
      Constructor = ' ',
      Field = ' ',
      Variable = ' ',
      Class = ' ',
      Interface = ' ',
      Module = ' ',
      Property = ' ',
      Unit = ' ',
      Value = ' ',
      Enum = ' ',
      Keyword = ' ',
      Snippet = ' ',
      Color = ' ',
      File = ' ',
      Reference = ' ',
      Folder = ' ',
      EnumMember = ' ',
      Constant = ' ',
      Struct = ' ',
      Event = ' ',
      Operator = ' ',
      TypeParameter = ' ',
    },

    icons_icons = {
      Text = '󰉿 ',
      Method = 'm ',
      Function = '󰊕 ',
      Constructor = ' ',
      Field = ' ',
      Variable = '󰆧 ',
      Class = '󰌗 ',
      Interface = ' ',
      Module = ' ',
      Property = ' ',
      Unit = ' ',
      Value = '󰎠 ',
      Enum = ' ',
      Keyword = '󰌋 ',
      Snippet = ' ',
      Color = '󰏘 ',
      File = '󰈙 ',
      Reference = ' ',
      Folder = '󰉋 ',
      EnumMember = ' ',
      Constant = '󰇽 ',
      Struct = ' ',
      Event = ' ',
      Operator = '󰆕 ',
      TypeParameter = '󰊄 ',
    },

    icons_2 = {
      Text = '󰉿 ',
      Method = '󰆧 ',
      Function = '󰊕 ',
      Constructor = ' ',
      Field = '󰜢 ',
      Variable = ' ',
      Class = '󰠱 ',
      Interface = ' ',
      Module = '󰅩 ',
      Property = '󰜢 ',
      Unit = '󰑭 ',
      Value = '󰎠 ',
      Enum = ' ',
      Keyword = '󰌋 ',
      Snippet = ' ',
      Color = '󰏘 ',
      File = '󰈙 ',
      Reference = '󰈇 ',
      Folder = '󰉋 ',
      EnumMember = ' ',
      Constant = '󰏿 ',
      Struct = '󰙅 ',
      Event = ' ',
      Operator = '󰆕 ',
      TypeParameter = ' ',
    },

    nvchad = {
      Namespace = '󰌗 ',
      Text = '󰉿 ',
      Method = '󰆧 ',
      Function = '󰆧 ',
      Constructor = ' ',
      Field = '󰜢 ',
      Variable = '󰀫 ',
      Class = '󰠱 ',
      Interface = ' ',
      Module = ' ',
      Property = '󰜢 ',
      Unit = '󰑭 ',
      Value = '󰎠 ',
      Enum = ' ',
      Keyword = '󰌋 ',
      Snippet = ' ',
      Color = '󰏘 ',
      File = '󰈚 ',
      Reference = '󰈇 ',
      Folder = '󰉋 ',
      EnumMember = ' ',
      Constant = '󰏿 ',
      Struct = '󰙅 ',
      Event = ' ',
      Operator = '󰆕 ',
      TypeParameter = '󰊄 ',
      Table = ' ',
      Object = '󰅩 ',
      Tag = ' ',
      Array = '[] ',
      Boolean = ' ',
      Number = ' ',
      Null = '󰟢 ',
      String = '󰉿 ',
      Calendar = ' ',
      Watch = '󰥔 ',
      Package = ' ',
      Copilot = ' ',
      Codeium = ' ',
      TabNine = ' ',
    },

    custom_icons = {
      Text = ' ',
      Method = ' ',
      Function = '󰊕 ',
      Constructor = '⌘ ',
      Field = '󰜢 ',
      Variable = '󰈜 ',
      Class = '󰠱 ',
      Interface = ' ',
      Module = '󰏓 ',
      Property = '󰜢 ',
      Unit = '󰑭 ',
      Value = '󰎠 ',
      Enum = ' ',
      Keyword = '󰔌 ',
      Snippet = '󰅱 ',
      Color = '󰏘 ',
      File = '󰈙 ',
      Reference = '󰈇 ',
      Folder = ' ',
      EnumMember = ' ',
      Constant = '󰐀 ',
      Struct = '󰙅 ',
      Event = ' ',
      treesitter = ' ',
      Operator = '󰆕 ',
      TypeParameter = ' ',
      fonts = ' ',
    },
  },
  ui = {
    file = '󰈔',
    files = '󰈢',
    folder = '󰉖',
    folders = '󰉓',
    open_folder = '󰝰',
    empty_folder = '󰉖',
    project_folder = '󰀼',
    buffers = '󰈙',
    restore = '󰦛',
    config = '󰒓',
    close = '󰅚',
    buffer_close = '󰅖',
    modified_buffer = '●',
    arrow_right_out = '󰧂',
    arrow_right = '󰁔',
    arrow_left = '',
    arrow_left_out = '󰧀',
    double_chevron = '󰄾',
    chevron = '󰅂',
    lsp_error = '󰅙 ',
    lsp_warn = '󰀦 ',
    lsp_hint = '󰌵 ',
    lsp_info = '󰋼 ',
    powerline_round_right = '',
    powerline_round_left = '',
    powerline_square_right = ' ',
    powerline_square_left = ' ',
    mode_icon = '󰀘 ',
    modified = '󰜄 ',
    plus_square = '󰜄',
    minus_square = '󰛲',
    empty = '󱋭',
    new = '󰎔',
    prompt_prefix = '󰋇 ',
    selection_caret = ' ',
  },
  git = {
    git = '󰊢 ',
    add = '󰐙 ',
    change = '󰐙 ',
    delete = '󰍷 ',
    unstaged = '● ',
    modified = '  ',
    renamed = '󱦰 ',
    ignored = '◌',
    conflict = '',
    staged = 'S',
    untracked = 'U',
  },
}
local datetime = os.date ' %H:%M. '
local num_plugins_loaded = require('lazy').stats().loaded

-- dashboard.section.header.val = {
--   [[                               __                ]],
--   [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
--   [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
--   [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
--   [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
--   [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
-- }

dashboard.section.header.val = {
  [[░▒▓████████▓▒░░▒▓█▓▒░░▒▓█▓▒░ ░▒▓██████▓▒░ ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓███████▓▒░       ░▒▓███████▓▒░ ░▒▓████████▓▒░░▒▓██████▓▒░ ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓██████████████▓▒░  ]],
  [[░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ]],
  [[░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒▒▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ]],
  [[░▒▓██████▓▒░  ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░       ░▒▓███████▓▒░ ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░ ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒▒▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ]],
  [[░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▓█▓▒░  ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ]],
  [[░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▓█▓▒░  ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ]],
  [[░▒▓█▓▒░        ░▒▓██████▓▒░  ░▒▓██████▓▒░ ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░░▒▓████████▓▒░░▒▓██████▓▒░    ░▒▓██▓▒░   ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ]],
  [[                                                                                                                                                                       ]],
  [[                                                                                                                                                                       ]],
  [[ ░▒▓███████▓▒░ ░▒▓██████▓▒░       ░▒▓█▓▒░░▒▓████████▓▒░      ░▒▓█▓▒░ ░▒▓███████▓▒░                                                                                     ]],
  [[░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░   ░▒▓█▓▒░          ░▒▓█▓▒░░▒▓█▓▒░                                                                                            ]],
  [[░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░   ░▒▓█▓▒░          ░▒▓█▓▒░░▒▓█▓▒░                                                                                            ]],
  [[ ░▒▓██████▓▒░ ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░   ░▒▓█▓▒░          ░▒▓█▓▒░ ░▒▓██████▓▒░                                                                                      ]],
  [[       ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░   ░▒▓█▓▒░          ░▒▓█▓▒░       ░▒▓█▓▒░                                                                                     ]],
  [[       ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░   ░▒▓█▓▒░          ░▒▓█▓▒░       ░▒▓█▓▒░░▒▓██▓▒░░▒▓██▓▒░░▒▓██▓▒░                                                             ]],
  [[░▒▓███████▓▒░  ░▒▓██████▓▒░       ░▒▓█▓▒░   ░▒▓█▓▒░          ░▒▓█▓▒░░▒▓███████▓▒░ ░▒▓██▓▒░░▒▓██▓▒░░▒▓██▓▒░                                                             ]],
  [[                                                                                                                                                                       ]],
  [[                                                                                                                                                                       ]],
  [[░▒▓█▓▒░░▒▓█▓▒░ ░▒▓██████▓▒░       ░▒▓███████▓▒░  ░▒▓██████▓▒░  ░▒▓███████▓▒░░▒▓████████▓▒░░▒▓██████▓▒░ ░▒▓███████▓▒░ ░▒▓███████▓▒░                                     ]],
  [[░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░          ░▒▓█▓▒░   ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░                                    ]],
  [[░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░          ░▒▓█▓▒░   ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░                                    ]],
  [[ ░▒▓██████▓▒░ ░▒▓████████▓▒░      ░▒▓███████▓▒░ ░▒▓████████▓▒░ ░▒▓██████▓▒░    ░▒▓█▓▒░   ░▒▓████████▓▒░░▒▓███████▓▒░ ░▒▓█▓▒░░▒▓█▓▒░                                    ]],
  [[   ░▒▓█▓▒░    ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░       ░▒▓█▓▒░   ░▒▓█▓▒░   ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░                                    ]],
  [[   ░▒▓█▓▒░    ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░       ░▒▓█▓▒░   ░▒▓█▓▒░   ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░                                    ]],
  [[   ░▒▓█▓▒░    ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓███████▓▒░ ░▒▓█▓▒░░▒▓█▓▒░░▒▓███████▓▒░    ░▒▓█▓▒░   ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓███████▓▒░                                     ]],
  [[                                                                                                                                                                       ]],
  [[                                                                                                                                                                       ]],
}

dashboard.section.buttons.val = {
  dashboard.button('e', icons.ui.file .. '  New file', '<cmd>enew<CR>'),
  dashboard.button('o', icons.ui.file .. '  Recent Files', '<cmd>Telescope oldfiles<cr>'),
  dashboard.button('f', icons.ui.open_folder .. '  Explorer', '<cmd>Explore<cr>'),
  dashboard.button('c', icons.ui.config .. '  Neovim config', '<cmd>e ~/.config/nvim/lua/user/ | cd %:p:h<cr>'),
  dashboard.button('l', '󰒲  Lazy', '<cmd>Lazy<cr>'),
  dashboard.button('q', icons.ui.close .. '  Quit NVIM', ':qa<CR>'),
}

local footer = {
  type = 'text',
  val = { '⚡' .. num_plugins_loaded .. ' plugins loaded.' },
  opts = { position = 'center', hl = 'Comment' },
}

local bottom_section = {
  type = 'text',
  val = 'Hi Glenn' .. ',' .. " It's" .. datetime .. 'How are you doing today?',
  opts = {
    position = 'center',
  },
}

local section = {
  header = dashboard.section.header,
  bottom_section = bottom_section,
  buttons = dashboard.section.buttons,
  footer = footer,
}

local opts = {
  layout = {
    { type = 'padding', val = 8 },
    section.header,
    { type = 'padding', val = 2 },
    section.buttons,
    { type = 'padding', val = 1 },
    section.bottom_section,
    { type = 'padding', val = 1 },
    section.footer,
  },
}

alpha.setup(opts)