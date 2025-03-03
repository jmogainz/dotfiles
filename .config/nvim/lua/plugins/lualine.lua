local function get_diagnostics_line_numbers()
  local diagnostics = vim.diagnostic.get(0)
  local error_lines = {}
  local warn_lines = {}

  for _, diag in ipairs(diagnostics) do
    if diag.severity == vim.diagnostic.severity.ERROR then
      table.insert(error_lines, diag.lnum + 1) -- lnum is 0-indexed
    elseif diag.severity == vim.diagnostic.severity.WARN then
      table.insert(warn_lines, diag.lnum + 1)
    end
  end

  local error_str = #error_lines > 0 and "E:" .. table.concat(error_lines, ",") or ""
  -- local warn_str = #warn_lines > 0 and "W:" .. table.concat(warn_lines, ",") or "" 

  -- if #error_str == 0 and #warn_str == 0 then
  --   return ""
  -- elseif #error_str == 0 then
  --   return warn_str
  -- elseif #warn_str == 0 then
  --   return error_str
  -- else
  --   return error_str .. " " .. warn_str
  -- end
  --
  if #error_str == 0 then
    return ""
  else
    return error_str
  end
end

-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require('lualine')

-- Gruvbox-inspired color table for highlights.
local colors = {
  bg       = '#282828', -- Gruvbox dark background
  fg       = '#ebdbb2', -- light foreground
  yellow   = '#fabd2f',
  cyan     = '#8ec07c',
  darkblue = '#83a598', -- used for mode component etc.
  green    = '#b8bb26',
  orange   = '#fe8019',
  violet   = '#d3869b',
  magenta  = '#fb4934',
  blue     = '#83a598', -- bright blue
  red      = '#fb4934',
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Custom function to get parent directory and file name
local function get_parent_dir_and_filename()
  local filepath = vim.fn.expand('%:p')
  local parent = vim.fn.fnamemodify(filepath, ':h:t')
  local filename = vim.fn.fnamemodify(filepath, ':t')
  return parent .. '/' .. filename
end

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    component_separators = '',
    section_separators = '',
    theme = {
      -- We are going to use lualine_c and lualine_x as left and right sections.
      normal = { c = { fg = colors.fg, bg = colors.bg } },
      inactive = { c = { fg = colors.fg, bg = colors.bg } },
    },
  },
  sections = {
    -- These are to remove the defaults.
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later.
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- Remove defaults.
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

-- Inserts a component in lualine_c at the left section.
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x at the right section.
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left {
  function()
    return '▊'
  end,
  color = { fg = colors.blue }, -- Uses bright blue for the block
  padding = { left = 0, right = 1 },
}

ins_left {
  -- Mode component.
  function()
    return '🕇'
  end,
  color = function()
    local mode_color = {
      n = colors.red,
      i = colors.green,
      v = colors.blue,
      [''] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [''] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ['r?'] = colors.cyan,
      ['!'] = colors.red,
      t = colors.red,
    }
    return { fg = mode_color[vim.fn.mode()] }
  end,
  padding = { right = 1 },
}

ins_left {
  -- Filesize component.
  'filesize',
  cond = conditions.buffer_not_empty,
}

ins_left {
  -- Parent directory and file name.
  function()
    return get_parent_dir_and_filename()
  end,
  cond = conditions.buffer_not_empty,
  -- Here you might want the anchor effect. For example, if you want the parent (anchor)
  -- to stand out, you could change this to use colors.darkblue or even a bold variant.
  color = { fg = colors.fg, gui = 'bold' },
}

ins_left { 'location' }

ins_left {
  -- Custom diagnostic component.
  function()
    return get_diagnostics_line_numbers()
  end,
}

ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }

ins_left {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = ' ' },
  diagnostics_color = {
    error = { fg = colors.red },
    warn = { fg = colors.yellow },
    info = { fg = colors.cyan },
    hint = { fg = colors.blue },
  },
}

-- Insert mid section. You can have any number of sections greater than 2.
ins_left {
  function()
    return '%='
  end,
}

ins_left {
  -- LSP server name.
  function()
    local msg = 'No Active Lsp'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  icon = ' LSP:',
  color = { fg = colors.fg, gui = 'bold' },
}

-- Add components to the right sections.
ins_right {
  'o:encoding',
  fmt = string.upper,
  cond = conditions.hide_in_width,
  color = { fg = colors.green, gui = 'bold' },
}

ins_right {
  'fileformat',
  fmt = string.upper,
  icons_enabled = false,
  color = { fg = colors.green, gui = 'bold' },
}

ins_right {
  'filetype',
  icons_enabled = true,
  color = { fg = colors.blue, gui = 'bold' },
}

-- ins_right {
--   'branch',
--   icon = '',
--   color = { fg = colors.violet, gui = 'bold' },
-- }

ins_right {
  'diff',
  -- Is it me or the symbol for modified us really weird
  symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
}

ins_right {
  function()
    return '▊'
  end,
  color = { fg = colors.blue },
  padding = { left = 1 },
}

-- Initialize lualine.
lualine.setup(config)

