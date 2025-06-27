require("CopilotChat").setup({
    model = "claude-sonnet-4",
    context = {"buffers"},
    window = {
        position = "right",
        width = 0.4,
    },
})
