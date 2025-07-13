require('copilot').setup({
  -- we only want the inline ghosts, not the side panel
  panel = { enabled = true },

  suggestion = {
    enabled      = true,   -- show the grey “ghost” text
    auto_trigger = true,   -- start suggesting as soon as you type
    debounce     = 75,     -- ms between LSP requests

    -- ⬇ keymaps that the plugin installs for you
    keymap = {
      accept  = '<C-l>',   -- mirrors your old mapping
      next    = '<M-]>',   -- cycle forward
      prev    = '<M-[>',   -- cycle backward
      dismiss = '<C-]>',
      accept_word = '<M-u>', -- accept the word
    }
  },

  copilot_model = "claude-sonnet-4",
})
