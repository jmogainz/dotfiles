require("CopilotChat").setup({
    model = "gemini-2.5-pro",
    context = {"buffers"},
    window = {
        position = "right",
        width = 0.4,
    },
})
