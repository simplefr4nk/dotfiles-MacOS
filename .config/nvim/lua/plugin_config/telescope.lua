local builtin = require('telescope.builtin')

vim.keymap.set('n', '<Space>ff', builtin.find_files, { desc = '[F]ind [F]iles in the open folder'})
vim.keymap.set('n', '<Space>fg', builtin.live_grep, { desc = '[F]ind what is typed inside the files on the open folder as doing [G]rep' })
vim.keymap.set('n', '<Space>of', builtin.oldfiles, { desc = '[O]pen old [F]iles'})
vim.keymap.set('n', '<Space><Space>', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = 'Search within the same file'})
vim.keymap.set('n', '<Space>fh', builtin.help_tags, { desc = '[F]ind and let searching in all [H]elping files' })
