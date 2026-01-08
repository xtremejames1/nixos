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

-- local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
-- parser_config.org = {
--   install_info = {
--     url = "https://github.com/milisims/tree-sitter-org",
--     revision = "main",
--     files = { "src/parser.c", "src/scanner.cc" },
--   },
--   filetype = "org",
-- }
