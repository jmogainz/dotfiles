require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "c", "json", "yaml", "cpp", "python", "make", "bash", "lua", "html", "gitignore",
    "dockerfile", "markdown", "vim", "cmake", "dot", "latex"
  },
  ignore_install = {},
  sync_install = false,
  modules = {},
  highlight = {
    enable = true,
    disable = { "python", "cpp" },
    additional_vim_regex_highlighting = false
  },
  indent = {
    enable = true,
  },
  auto_install = true,
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ao"] = "@conditional.outer",
        ["io"] = "@conditional.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
        ["ap"] = "@parameter.outer",
        ["ip"] = "@parameter.inner",
        ["aC"] = "@comment.outer",
        ["iC"] = "@comment.inner",
      },
    },
  },
}

