require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'onedark',
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '', right = ''},
  },
  sections = {
    lualine_a = {
      {'filename',path = 1,}
    },
    lualine_b = {'branch', 'diff'},
    lualine_c = {}, -- remove redondant filename
    lualine_x = {'encoding', 'filetype'},
  }
}
