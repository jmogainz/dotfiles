require('mini.animate').setup{
  -- Cursor path
  cursor = {
    -- Whether to enable this animation
    enable = false,
    timing = function() return 5 end,
  },

  -- Vertical scroll
  scroll = {
    -- Whether to enable this animation
    enable = false,

    -- -- Timing of animation (how steps will progress in time)
    timing = function() return 5 end,

    -- -- Subscroll generator based on total scroll
    -- subscroll = --<function: implements equal scroll with at most 60 steps>,
  }

}
