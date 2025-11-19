require("CopilotChat").setup({
    model = "claude-sonnet-4.5",
    context = {"buffer"},
    window = {
        position = "right",
        width = 0.4,
    },
})
