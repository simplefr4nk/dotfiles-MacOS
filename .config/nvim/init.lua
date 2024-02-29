-- require other config files
require("plugins")
require("plugin_config")

-- Peronal shortcuts
vim.keymap.set('n', '\\', ':noh<return><esc>')

-- for easier syntax
local set = vim.opt

set.number = true -- show number on left side
set.rnu = true -- style the numbers relative to the line
set.tabstop = 2 -- size of tab
set.shiftwidth = 2
set.expandtab = true -- expand tab on files

set.cursorline = true -- highlight line with cursor
set.scrolloff = 5 -- stop 5 lines before start scrolling down
set.showcmd = true -- show commands
