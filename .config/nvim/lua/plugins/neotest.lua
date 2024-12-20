require("neotest").setup({
  adapters = {
   require("neotest-go")({
      dap = { justMyCode = false },
    }),
  },
})
