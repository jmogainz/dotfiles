-- Capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.offsetEncoding = { "utf-16" }

-- Shared on_attach function
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local opts = { noremap = true, silent = true }

  -- Existing Language Server Protocol (LSP) mappings
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gs', '<Cmd>ClangdSwitchSourceHeader<CR>', opts)
  buf_set_keymap('n', 'gA', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<Leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<Leader>f', '<Cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts)
end

-- Clangd
vim.lsp.config('clangd', {
  cmd = {
    "clangd",
    "--header-insertion=never",
    "--completion-style=detailed",
    "--cross-file-rename",
    "--clang-tidy",
  },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Pyright
vim.lsp.config('pyright', {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        typeCheckingMode = "standard",
      },
    },
  },
})

-- Lua language server
vim.lsp.config('lua_ls', {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

-- Dart language server
vim.lsp.config('dartls', {
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Go language server
vim.lsp.config('gopls', {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    gopls = {
      buildFlags = { "-tags=dev_test,dev,integration,unit" },
    },
  },
})

-- Enable all of the above Language Server Protocol (LSP) configs
vim.lsp.enable({ 'clangd', 'pyright', 'lua_ls', 'dartls', 'gopls' })

