require'nvim-treesitter.configs'.setup {
  ensure_installed = { -- languages to install
    "c", "cpp", "lua", "rust", "python", "html", "css", "javascript", "typescript", "go"
  },
  sync_install = false,
  auto_install = true,
  highlight = { -- highlighting provided by treesitter
    enable = true,
    -- additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
}
