-- Key mappings
vim.api.nvim_set_keymap('n', '<Leader>mp', ':MarkdownPreview<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-l>', 'copilot#Accept("<CR>")', { silent = true, expr = true, script = true })
vim.api.nvim_set_keymap('n', '<Leader>s', ':Files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-b>', ':History<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>eh', ':split <bar> :History<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ev', ':vsplit <bar> :History<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>rg', ':Rg<Space>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fp', '<Cmd>lua require("plugins.custom_functions").copy_and_print_file_path()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>p', '<Cmd>lua require("plugins.custom_functions").copy_and_print_dir_path()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>w', '<Plug>(easymotion-bd-w)', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>c', '<Plug>(easymotion-s)', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', ':NERDTreeFind<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>tn', ':tabnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>tc', ':tabclose<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'mp', ':MarkdownPreview<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', '<C-s>', '<Cmd>lua require("plugins.custom_functions").copy_snippet_info()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>mm', ':BookmarkToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>mi', ':BookmarkAnnotate<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>mn', ':BookmarkNext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>mp', ':BookmarkPrev<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>mc', ':BookmarkClear<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ma', ':BookmarkShowAll<CR>', { noremap = true, silent = true })
vim.g.VM_maps = {
  ['Find Under']         = '<C-n>',
  ['Find Subword Under'] = '<C-n>',
  ['Select All']         = '<C-p>',
  ['Add Cursor Down']    = '<C-Down>',
  ['Add Cursor Up']      = '<C-Up>',
  ['Remove Region']      = 'q',  -- Change to your preferred key
  ['Skip Region']        = 'Q',  -- Change to your preferred key
  ['Remove Last Region'] = 'R',  -- Change to your preferred key
}
vim.api.nvim_set_keymap('n', '<C-l>', ':NvimTreeFindFile<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>u', ':UndotreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>i', ':IlluminateToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>re', "<cmd>lua require('refactoring').refactor('Extract Function')<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'cd', ':TSCppDefineClassFunc<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'cD', '<Cmd>lua require("plugins.custom_functions").create_cpp_declaration()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>a', ':AerialOpen<CR>', { noremap = true, silent = true })
vim.cmd [[
amenu PopUp.Go\ to\ Definition :lua vim.lsp.buf.definition()<CR>
amenu PopUp.Go\ to\ Declaration :lua vim.lsp.buf.declaration()<CR>
amenu PopUp.Go\ to\ References :lua vim.lsp.buf.references()<CR>
amenu PopUp.Go\ to\ Tree :NvimTreeFindFile<CR>'
amenu PopUp.Go\ to\ Header/Source :ClangdSwitchSourceHeader<CR>
]]
-- Map the mouse buttons to jump commands using :lua command
vim.api.nvim_set_keymap('n', '<LeftMouse><ScrollWheelDown>', '<C-o>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<LeftMouse><ScrollWheelUp>', '<C-i>', { noremap = true, silent = true })
