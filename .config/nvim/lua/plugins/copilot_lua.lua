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

  copilot_model = "gpi-4.1-copilot",

  -- 2. add other trees you want Copilot to scan up-front
  workspace_folders = {
    "~/poof-meta-repo/meta-service/services/jobs-service/internal",
  },

  -- enable in every language you care about
  filetypes = {
    markdown = true,       -- off by default – turn it on
    yaml     = false,      -- leave disabled (chatter)
  },

  copilot_node_command = 'node',  -- whatever `node -v` v20+ resolves to
})
