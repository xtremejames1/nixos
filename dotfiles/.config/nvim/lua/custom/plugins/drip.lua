return {
  -- {
  --   'catppuccin/nvim',
  --   name = 'catppuccin',
  --   priority = 1000,
  -- },
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    config = function()
      vim.cmd 'colorscheme kanagawa'
      vim.cmd 'highlight CursorColumn guibg=#2f3d3d'
      vim.cmd 'highlight CursorLine guibg=#2f3d3d'
      vim.cmd 'set cursorcolumn'
      vim.cmd 'set cursorline'
    end,
  },
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
  },
  {
    'karb94/neoscroll.nvim',
    config = function()
      neoscroll = require 'neoscroll'
      neoscroll.setup {
        easing = 'quartic',
      }
      local keymap = {
        ['<C-u>'] = function()
          neoscroll.ctrl_u { duration = 150 }
        end,
        ['<C-d>'] = function()
          neoscroll.ctrl_d { duration = 150 }
        end,
        -- Use the "circular" easing function
        ['<C-b>'] = function()
          neoscroll.ctrl_b { duration = 250 }
        end,
        ['<C-f>'] = function()
          neoscroll.ctrl_f { duration = 250 }
        end,
        -- When no value is passed the `easing` option supplied in `setup()` is used
        ['<C-y>'] = function()
          neoscroll.scroll(-0.1, { move_cursor = false, duration = 100 })
        end,
        ['<C-e>'] = function()
          neoscroll.scroll(0.1, { move_cursor = false, duration = 100 })
        end,
      }
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
  },
  {
    'stevearc/dressing.nvim',
    opts = {},
  },
  {
    'RRethy/vim-illuminate',
    opts = {},
    config = function()
      require('illuminate').configure()
    end,
  },
  {
    'echasnovski/mini.indentscope',
    opts = {
      -- symbol = "▏",
      symbol = '│',
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = {
          'help',
          'alpha',
          'Alpha',
          'dashboard',
          'neo-tree',
          'Trouble',
          'trouble',
          'lazy',
          'mason',
          'notify',
          'toggleterm',
          'lazyterm',
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  }
  -- {
  --   'freddiehaddad/feline.nvim',
  --   opts = {},
  --   config = function()
  --     local ctp_feline = require('catppuccin.groups.integrations.feline')
  --
  --     ctp_feline.setup()
  --
  --     require("feline").setup({
  --       components = ctp_feline.get(),
  --     })
  --   end
  -- }
}
