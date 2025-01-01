require('lualine').setup({
  sections = {
    lualine_c = {}
  },
  options = {
    section_separators = '',
    component_separators = ''
  },
  extensions = {
    trouble = function()
      local trouble = require("trouble")
      local symbols = trouble.statusline({
        mode = "lsp_document_symbols",
        groups = {},
        title = false,
        filter = { range = true },
        format = "{kind_icon}{symbol.name:Normal}",
        hl_group = "lualine_c_normal",
      })
      return {
        sections = {
          lualine_c = {
            {
              symbols.get,
              cond = symbols.has,
            }
          }
        }
      }
    end
  }
})
