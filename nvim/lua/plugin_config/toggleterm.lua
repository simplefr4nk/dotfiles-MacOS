local fn = vim.fn
require('toggleterm').setup({
  -- vim.keymap.set('n', '<Spacet',
  open_mapping = [[<c-\>]],
  shade_filetypes = { 'none' },
  start_in_insert = true,
  direction = 'vertical',
  highlights = {
    FloatBorder = { link = 'FloatBorder' },
    NormalFloat = { link = 'NormalFloat' },
  },
  size = function(term)
    if term.direction == 'horizontal' then
      return 8
    elseif term.direction == 'vertical' then
      return math.floor(vim.o.columns * 0.25)
    end
  end,
})
