require('lazy').setup {
  defaults = {
    lazy = true,
  },
  spec = {
    -- import your plugins
    { import = 'plugins' },
  },
  -- automatically check for plugin updates
  checker = { enabled = false },
  install = { missing = false },
}
