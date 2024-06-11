-- Initialize packer.nvim
vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Packer can manage itself
  use 'github/copilot.vim'
  use 'nvim-lua/plenary.nvim'
  use 'farmergreg/vim-lastplace'
  use { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end }
  use 'junegunn/fzf.vim'
  use 'windwp/nvim-autopairs'
  use 'sheerun/vim-polyglot'
  use { 'dracula/vim', as = 'dracula' }
  use { 'morhetz/gruvbox', as = 'gruvbox'}
  use 'nvim-tree/nvim-web-devicons'
  use 'nvim-tree/nvim-tree.lua'
  use 'Xuyuanp/nerdtree-git-plugin'
  use 'dense-analysis/ale'
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lua'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip'
  use 'easymotion/vim-easymotion'
  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'
  use 'sindrets/diffview.nvim'
  use 'airblade/vim-gitgutter'
  use 'tpope/vim-fugitive'
  use 'Pocco81/auto-save.nvim'
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'nvim-treesitter/nvim-treesitter-refactor'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install && yarn add tslib' }
  use 'tpope/vim-abolish'
  use 'j-hui/fidget.nvim'
  use 'MattesGroeger/vim-bookmarks'
  use 'mg979/vim-visual-multi'
  use 'mbbill/undotree'
  use 'nvim-lualine/lualine.nvim'
  use 'lambdalisue/vim-suda'
  use 'aklt/plantuml-syntax'
  use 'weirongxu/plantuml-previewer.vim'
  use 'tyru/open-browser.vim'
end)

-- Load individual plugin configurations
require('plugins.autopairs')
require('plugins.auto-save')
require('plugins.cmp')
require('plugins.diffview')
require('plugins.diagnostics').setup()
require('plugins.fidget')
require('plugins.lspconfig')
require('plugins.nvim-web-devicons')
require('plugins.treesitter')
require('plugins.nvim-tree')
require('plugins.lualine')
