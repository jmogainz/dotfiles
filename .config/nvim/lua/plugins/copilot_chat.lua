require("CopilotChat").setup({
    model = "claude-sonnet-4.6",
    context = {"buffer"},
    window = {
        position = "right",
        width = 0.4,
    },
})
