require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    "lua_ls", -- lua
    "marksman", -- markdown
    "pylsp", -- python
    "rust_analyzer", -- rust
    "gggolangci_lint_l"
  }
})

-- Add additional capabilities supported by nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()


local lspconfig = require('lspconfig')

local servers = { 'rust_analyzer', 'pylsp', 'rust_analyzer', 'marksman', 'lua_ls', 'ggolangci_lint_ls' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end
