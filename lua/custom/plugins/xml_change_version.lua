-- Function to find and change version number in the current line
local function change_version()
  -- Get current cursor position
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local line = cursor_pos[1]
  local col = cursor_pos[2]

  -- Get the content of the current line
  local current_line = vim.api.nvim_get_current_line()

  -- Pattern to match version numbers between tag delimiters
  -- This pattern looks for: ">digit.digit.digit</"
  -- It can match patterns like:
  --   ">1.2.3</"
  --   ">10.0.1</"
  --   ">2.0.20-SNAPSHOT</"
  local pattern = '>([-%.%w]+)</'

  -- Find all matches in the current line
  local matches = {}
  local start_pos = 1

  while true do
    local match_start, match_end = current_line:find(pattern, start_pos)
    if not match_start then
      break
    end

    -- Extract the version text (without > and </)
    local version_start = match_start + 1
    local version_end = match_end - 2
    local version_text = current_line:sub(version_start, version_end)

    table.insert(matches, {
      start = version_start - 1, -- -1 for 0-indexing
      end_pos = version_end - 1, -- -1 for 0-indexing
      text = version_text,
    })

    start_pos = match_end
  end

  -- Find the closest match to cursor
  local closest_match = nil
  local min_distance = math.huge

  for _, match in ipairs(matches) do
    -- Check if this looks like a version number (contains digits and possibly dots)
    if match.text:match '%d+' then
      local distance = math.min(math.abs(col - match.start), math.abs(col - match.end_pos))

      if distance < min_distance then
        min_distance = distance
        closest_match = match
      end
    end
  end

  -- If we found a match, change it
  if closest_match then
    -- Move cursor to the start of version text (right after the '>')
    vim.api.nvim_win_set_cursor(0, { line, closest_match.start })

    -- Select and delete the version text
    local version_length = closest_match.end_pos - closest_match.start + 1

    -- Use visual mode to select the exact text and delete it
    vim.cmd('normal! v' .. (version_length - 1) .. 'ld')

    -- Move cursor one position forward before entering insert mode
    -- vim.cmd('normal! l')

    -- Enter insert mode
    vim.cmd 'startinsert'
  else
    -- Notify if no version found
    print 'No version pattern found on this line'
  end
end

-- Map 'cv' to change_version function (normal mode)
vim.keymap.set('n', 'cv', change_version, { noremap = true, silent = true, desc = 'Change XML version number' })

-- Return empty table since this is a configuration file
return {}
