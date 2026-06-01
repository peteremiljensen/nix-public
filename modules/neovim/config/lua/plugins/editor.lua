return {
  {
    'lualine',
    lazy = false,
    -- event = 'DeferredUIEnter',
    after = function()
      local opts = {}

      -- vim.notify(vim.inspect(require 'lualine.themes.kanagawa'))

      opts.options = {
        -- theme = "auto",
        -- theme = require 'lualine.themes.kanagawa',
        theme = 'nordic',
        globalstatus = true,
        disabled_filetypes = {
          statusline = { 'dashboard', 'alpha', 'starter' },
        },
        section_separators = '',
        component_separators = '',
      }
      opts.extensions = { 'neo-tree' }

      opts.sections = {
        lualine_b = { 'branch', 'diff', 'diagnostics' },
      }

      table.insert(opts.sections.lualine_b, 4, {
        'macro-recording',
        fmt = function()
          local recording_register = vim.fn.reg_recording()
          if recording_register == '' then
            return ''
          else
            return 'Recording @' .. recording_register
          end
        end,
      })

      require('lualine').setup(opts)
    end,
  },
}
