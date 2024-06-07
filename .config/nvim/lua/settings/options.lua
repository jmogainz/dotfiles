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

-- Bookmarks settings
vim.g.bookmark_no_default_key_mappings = 1

-- FZF settings
vim.g.fzf_layout = { window = { width = 1.00, height = 1.00, wrap = true } }
vim.api.nvim_create_user_command('Rg', function(opts)
    local args = table.concat(opts.fargs, " ")
    local command = 'rg --column --line-number --no-heading --color=always ' .. args
    vim.fn['fzf#vim#grep'](command, 1, vim.fn['fzf#vim#with_preview'](), opts.bang)
end, { bang = true, nargs = '*' })
vim.env.FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!.git/*"'
vim.env.FZF_DEFAULT_OPTS = '--bind=ctrl-j:down,ctrl-k:up'
vim.env.FZF_DEFAULT_OPTS = '--border=none --preview-window=border-none,wrap --bind=?:toggle-preview --preview "echo {}"'

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
vim.g.ale_cpp_clang_options = '-Wall -Wextra -Wpedantic -Wconversion -Wsign-conversion'
vim.g.ale_cpp_gcc_options = '-std=c++17 -Wall -O2 -Wextra -Wpedantic -Wconversion -Wsign-conversion'
vim.g.ale_cpp_cc_options = '-Wall -Wextra -Wpedantic Wsign-conversion -Wno-c++17-extensions'
vim.g.ale_linters = {
    cpp = {'clang', 'g++'},
    python = {'flake8', 'pylint', 'mypy'}
}
vim.g.ale_verbose = 1

vim.g.undotree_SplitWidth = 60        -- Width of the undotree window
vim.g.undotree_SetFocusWhenToggle = 1 -- Focus the undotree window when toggled
