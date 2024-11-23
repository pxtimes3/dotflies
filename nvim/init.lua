-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require('neo-tree').setup {
  filesystem = {
    filtered_items = {
      visible = true,
      hide_dotfiles = false,
      hide_gitignored = false,
    }
  }
}

-- vim.g.clipboard = {
-- name = 'OSC 52',
--  copy = {
--     ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
--     ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
--   },
--  paste = {
--    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
--      ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
--    },
-- }
vim.api.nvim_set_option("clipboard","unnamedplus") 
