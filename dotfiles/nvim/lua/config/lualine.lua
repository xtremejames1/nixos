require('lualine').setup {
  options = {
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' }
  }
}

-- After initial setup, modify the configuration
local trouble = require("trouble")
local symbols = trouble.statusline({
  mode = "lsp_document_symbols",
  groups = {},
  title = false,
  filter = { range = true },
  format = "{kind_icon}{symbol.name:Normal}",
  hl_group = "lualine_c_normal",
})

-- Insert the symbols component into lualine_c
table.insert(require('lualine').get_config().sections.lualine_c, {
  symbols.get,
  cond = symbols.has,
})

