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
  use 'lervag/vimtex'
  use 'RRethy/vim-illuminate'
  use 'ThePrimeagen/refactoring.nvim'
  use 'p00f/clangd_extensions.nvim'
  use 'Badhi/nvim-treesitter-cpp-tools'
  -- use {'echasnovski/mini.nvim', branch = 'stable'}
  use 'nvim-treesitter/nvim-treesitter-context'
  use 'stevearc/aerial.nvim'
  use 'folke/trouble.nvim'
  use { 'MeanderingProgrammer/render-markdown.nvim', after = 'nvim-treesitter' }
  use 'mfussenegger/nvim-dap'
  use {'nvim-neotest/neotest', requires = {'nvim-neotest/nvim-nio', 'nvim-lua/plenary.nvim', 'antoinemadec/FixCursorHold.nvim',
       'nvim-treesitter/nvim-treesitter'}}
  use 'nvim-neotest/neotest-go'
  use 'stevearc/dressing.nvim'
  use 'MunifTanjim/nui.nvim'
  -- use {'yetone/avante.nvim', run = 'make BUILD_FROM_SOURCE=true'}
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
require('plugins.illuminate')
require('plugins.custom_functions')
require('plugins.refactoring')
require('plugins.cpp-tools')
require('plugins.aerial')
require('plugins.trouble')
require('plugins.neotest')
-- require('plugins.avante')
