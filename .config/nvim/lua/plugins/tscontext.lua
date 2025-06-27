require('treesitter-context').setup{
  enable              = true,
  multiline_threshold = 1,   -- show at most 1 line per node
  trim_scope          = 'inner', -- drop inner lines first (so the
}
