local M = {}

M.setup = function()
    -- Configure diagnostics
    vim.diagnostic.config({
        virtual_text = false, -- Disable virtual text
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
            border = "rounded",
            source = "always", -- Include the source in the diagnostics
            header = "",
            prefix = "",
        },
    })

    -- Customize floating window colors
    vim.cmd([[
      highlight DiagnosticFloatingError guifg=#FF0000 guibg=#1E1E1E gui=bold
      highlight DiagnosticFloatingWarn guifg=#FFA500 guibg=#1E1E1E gui=bold
      highlight DiagnosticFloatingInfo guifg=#00FFFF guibg=#1E1E1E gui=bold
      highlight DiagnosticFloatingHint guifg=#00FF00 guibg=#1E1E1E gui=bold
      highlight NormalFloat guibg=#1E1E1E
      highlight FloatBorder guifg=#00FFFF guibg=#1E1E1E
    ]])
end

return M
