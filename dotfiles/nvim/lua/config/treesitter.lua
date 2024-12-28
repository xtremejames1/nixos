local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
ts_update()
require("nvim-treesitter.configs").setup {
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
}

