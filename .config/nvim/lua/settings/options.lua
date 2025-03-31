-- General settings
vim.o.mouse = 'a'
vim.o.number = true
vim.o.relativenumber = true
vim.o.clipboard = 'unnamedplus'
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.wrap = true
vim.o.cursorline = true
vim.o.timeoutlen = 300
vim.o.smartindent = false
vim.opt.fixeol = false
vim.opt.shada = "'1000,<50,:1000,s10,h"

-- Plantuml settings
vim.g['plantuml_previewer#plantuml_jar_path'] = '/usr/share/java/plantuml/plantuml.jar'

-- LaTeX settings
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_compiler_method = 'latexmk'
vim.g.vimtex_view_general_viewer = 'zathura'
vim.g.vimtex_quickfix_mode = 0
vim.g.vimtex_lint_enabled = 0
vim.g.vimtex_check_enabled = 0

-- Suda settings
vim.g.suda_prompt = 'Password: '

-- Bookmarks settings
vim.g.bookmark_no_default_key_mappings = 1

-- FZF settings
vim.g.fzf_layout = { window = { width = 1.00, height = 1.00, wrap = true } }
vim.api.nvim_create_user_command('Rg', function(opts)
    local args = table.concat(opts.fargs, " ")
    local command = 'rg --no-ignore --column --line-number --no-heading --color=always --glob "!.git/*" --glob "!.cache/*" ' .. args
    vim.fn['fzf#vim#grep'](command, 1, vim.fn['fzf#vim#with_preview'](), opts.bang)
end, { bang = true, nargs = '*' })
vim.env.FZF_DEFAULT_COMMAND = 'rg --files -u --hidden --glob "!.git/*" --glob "!.cache/*"'
vim.env.FZF_DEFAULT_OPTS = '--bind=ctrl-j:down,ctrl-k:up'
vim.env.FZF_DEFAULT_OPTS = '--border=none --preview-window=border-none,wrap,hidden --bind=?:toggle-preview --preview "echo {}"'

-- Colorscheme settings
vim.cmd('syntax enable')
vim.o.background = 'dark'
vim.cmd('colorscheme dracula')

-- Enable persistent undo
vim.o.undofile = true
local target_path = vim.fn.expand('~/.config/nvim/undodir')
if not vim.fn.isdirectory(target_path) then
  vim.fn.mkdir(target_path, 'p', 0700)
end
vim.o.undodir = target_path

-- Copilot settings
vim.g.copilot_enabled = 1
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true

-- GitGutter settings
vim.g.gitgutter_enabled = 1

-- ALE settings
vim.g.ale_cpp_clang_options = '-Wall -Wextra -Wpedantic -Wconversion -Wsign-conversion --header-insertion=never'
vim.g.ale_cpp_gcc_options = '-std=c++17 -Wall -O2 -Wextra -Wpedantic -Wconversion -Wsign-conversion'
vim.g.ale_cpp_cc_options = '-Wall -Wextra -Wpedantic Wsign-conversion'
vim.g.ale_linters = {
    cpp = {'clang', 'g++'},
    c = {},
    python = {'flake8', 'pylint', 'mypy'},
    tex = {},
    lua = {},
    dart = {},
    go = {},
}
vim.g.ale_verbose = 1

-- UndoTree settings
vim.g.undotree_SplitWidth = 60        -- Width of the undotree window
vim.g.undotree_SetFocusWhenToggle = 1 -- Focus the undotree window when toggled

-- Vim Illuminate
-- Change the highlight style
vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })

-- Auto-update highlight style on colorscheme change
vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  pattern = { "*" },
  callback = function()
    vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
    vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
    vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
  end
})

vim.cmd([[
  augroup AerialLineNumbers
    autocmd!
    autocmd FileType aerial setlocal number relativenumber
  augroup END
]])

vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
  },
}
