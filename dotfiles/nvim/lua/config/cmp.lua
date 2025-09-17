-- See `:help cmp`
local cmp = require 'blink.cmp'
local luasnip = require 'luasnip'
luasnip.config.setup {}

cmp.setup {
  snippets = { preset = 'luasnip' },
  -- ensure you have the `snippets` source (enabled by default)
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
}

