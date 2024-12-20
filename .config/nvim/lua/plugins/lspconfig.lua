local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.offsetEncoding = { "utf-16" }

local lspconfig = require('lspconfig')

-- Shared on_attach function
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local opts = { noremap=true, silent=true }

    -- Existing LSP mappings
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

lspconfig.clangd.setup{
    cmd = { "clangd", "--header-insertion=never", "--completion-style=detailed", "--cross-file-rename", "--clang-tidy" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    capabilities = capabilities,
    on_attach = on_attach,
}

lspconfig.pyright.setup{
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
}

lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,  -- Disable the third-party library check
      },
      telemetry = {
        enable = false,  -- Disable telemetry data
      },
    },
  },
  capabilities = capabilities,
  on_attach = on_attach,
}

lspconfig.dartls.setup{
    capabilities = capabilities,
    on_attach = on_attach,
}

lspconfig.gopls.setup{
    capabilities = capabilities,
    on_attach = on_attach,
}
