require("neorg").setup({
  load = {
    ["core.defaults"] = {},
    ["core.concealer"] = {
      config = { -- We added a `config` table!
        icon_preset = "diamond", -- And we set our option here.
      },
    },
    ["core.completion"] = {
      config = {
        engine = "nvim-cmp",
      }
    },
    ["core.dirman"] = {
      config = {
        workspaces = {
          notes = "~/notes",
        },
        default_workspace = "notes",
      },
    },
    -- ["core.integrations.image"] = {},
    -- ["core.latex.renderer"] = {},
  }
})

