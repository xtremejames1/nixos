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

