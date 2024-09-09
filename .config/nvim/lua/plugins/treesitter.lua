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
    disable = { "cpp" },
    additional_vim_regex_highlighting = false
  },
  auto_install = false,
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
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]f"] = "@function.outer",
      },
      goto_next_end = {
        ["]F"] = "@function.outer",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
      },
      goto_previous_end = {
        ["[F"] = "@function.outer",
      },
    },
  },
}

