return {
  {
    'neo-tree',
    keys = {
      {
        '<leader>e',
        '<Cmd>Neotree reveal<CR>',
        mode = 'n',
        desc = 'NeoTree reveal',
        silent = true,
      },
    },
    opts = {
      filesystem = {
        window = {
          mappings = {
            ['<leader>e'] = 'close_window',
          },
        },
      },
    },
  },
}
