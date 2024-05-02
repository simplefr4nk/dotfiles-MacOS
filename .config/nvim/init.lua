local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

-- Enable LazyVim auto format
vim.g.autoformat = true

require("lazy").setup({
    { -- gruvbox theme
        "ellisonleao/gruvbox.nvim", priority = 1000
    },
    {  -- distraction free
        "junegunn/goyo.vim",
        keys = {
          { "<Leader>g", "<cmd>Goyo<cr>", desc = "Goyo" },
        }
    },
    {  -- dimm not selected rows
        "junegunn/limelight.vim",
        keys = {
          { "<Leader>l", "<cmd>Limelight!!<cr>", desc = "Limelight" },
        }
    },
    { -- markdown previewer
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
        keys = {
            { "<Leader>p", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview"  }
        }
    },
    { -- syntax highlight for markdown
        "plasticboy/vim-markdown"
    },
    { -- Nvim-Tree
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
          "nvim-tree/nvim-web-devicons",
        },
        config = function()
          require("nvim-tree").setup {}
        end,
        keys = {
          { "<Leader>n", "<cmd>NvimTreeFindFileToggle<cr>", desc = "Toggle Nvim-Tree" },
        }
    },
    { -- Line above with name of buffers
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        keys = {
          { "<Leader><Left>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
          { "<Leader><Right>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
          { "<C-S-w>", "<cmd>bd<cr>", desc = "Close buffer" },
        },
        opts = {
          options = {
            offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "center",
              separator = true,
            }
          },
            show_buffer_icons = true,
          },
        },
    },
    { -- bottom line with more information
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
          require('lualine').setup {
            options = {
              icons_enabled = true,
              theme = 'gruvbox',
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
        end
    },
    { -- plenary
        "nvim-lua/plenary.nvim",
    },
    { -- telescope
    "nvim-telescope/telescope.nvim",
    tag = '0.1.5',
    event = "VeryLazy",
    requires = { 'nvim-lua/plenary.nvim' }, -- 'dependencies' should be 'requires'
    keys = function()
        return {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "[F]ind [F]iles" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "[F]indlike [G]rep" },
            { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "[O]pen old [F]iles" },
            { "<leader><Space>", function()
                require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                    winblend = 10,
                    previewer = false,
                })
            end, desc = 'Search within the same file' }, -- Moved 'desc' field to the end
        }
    end,
},
    ---------------------------------------------------------------
    ------------------------- Coding part ------------------------- 
    ---------------------------------------------------------------
    { -- treesitter
        "nvim-treesitter/nvim-treesitter",
        opts = {
          ensure_installed = {
            "bash",
            "yaml",
            "go",
            "lua",
          },
        }
    },
    { -- show indent with a line
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {}
    },
    { -- show keybinds
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
        }
    },
    { -- multiple cursor
        "brenton-leighton/multiple-cursors.nvim",
        version = "*",  -- Use the latest tagged version
        opts = {},  -- This causes the plugin setup function to be called
        keys = {
          {"<C-Down>", "<Cmd>MultipleCursorsAddDown<CR>", mode = {"n", "i"}},
          {"<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>", mode = {"n", "i"}},
          {"<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", mode = {"n", "i"}},
          {"<Leader>a", "<Cmd>MultipleCursorsAddMatches<CR>", mode = {"n", "x"}, desc = "Add multiple cursor that match"},
          {"<Leader>d", "<Cmd>MultipleCursorsAddJumpNextMatch<CR>", mode = {"n", "x"}, desc = "Jump to and add the next cursor that match"},
          {"<Leader>D", "<Cmd>MultipleCursorsJumpNextMatch<CR>"}, desc = "Jump to the next multiple cursor"},
    },
    { -- easier comments
        'numToStr/Comment.nvim',
            config = function()
                require('Comment').setup()
            end,
            keys = {
                { "n", "<Leader>cc", "<cmd>:normal gcc<cr>", desc = "Toggle Comment using line" },
                { "n", "<Leader>cb", "<cmd>:normal gbc<cr>", desc = "Toggle Comment using block" },
                { "v", "<Leader>cc", "<cmd>:normal gc<cr>", desc = "Toggle Comment using line" },
                { "v", "<Leader>cb", "<cmd>:normal gb<cr>", desc = "Toggle Comment using block" },
            },
            lazy = false,
    },
    { -- Go development ide
        "ray-x/go.nvim",
        dependencies = {  -- optional packages
          "ray-x/guihua.lua",
          "neovim/nvim-lspconfig",
          "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require('go').setup({
                gofmt_command = 'goimports'
            })
        end,
        event = {"CmdlineEnter"},
        ft = {"go", 'gomod'},
        build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    },
    -- LSP configuration
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = function()
          require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        opts = {
          auto_install = true,
        },
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            local lspconfig = require("lspconfig")
            lspconfig.gopls.setup({
              capabilities = capabilities
            })
            lspconfig.html.setup({
              capabilities = capabilities
            })
            lspconfig.lua_ls.setup({
              capabilities = capabilities
            })

            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "<leader>dd", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "<leader>rr", vim.lsp.buf.references, {})
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
        end,
    },
      -- Autocompletions
    {
        "hrsh7th/cmp-nvim-lsp"
    },
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
          "saadparwaiz1/cmp_luasnip",
          "rafamadriz/friendly-snippets",
        },
    },
    {
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                snippet = {
                    expand = function(args)
                      require("luasnip").lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" }, -- For luasnip users.
                }, {
                    { name = "buffer" },
                }),
            })
        end,
    },
})

-- theme
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

-- markdown settings
vim.g.vim_markdown_frontmatter = 1 -- yaml fontmatter
vim.g.vim_markdown_folding_disabled = 1 -- disable folding
vim.opt.conceallevel = 2 -- concealing
vim.g.vim_markdown_math = 1 -- latex
vim.g.vim_markdown_strikethrough = 1 -- strikethrough
vim.g.vim_markdown_autowrite = 1 -- atosave when following a link
vim.g.vim_markdown_no_extensions_in_markdown = 1 -- can omit .md for link
vim.g.markdown_recommended_style = 0 -- Fix markdown indentation settings

-- basic settings
vim.opt.shiftwidth = 4 -- 4 space as tab
vim.opt.number = true -- line number
vim.opt.expandtab = true -- expand tab on files
vim.opt.scrolloff = 5 -- stop 5 lines before start scrolling down
vim.opt.showcmd = true -- show commands
vim.opt.termguicolors = true -- True color support
vim.opt.ignorecase = true -- Ignore case
vim.opt.cursorline = true -- highlight the line with thr cursor in it
vim.opt.clipboard="unnamedplus" -- copy to clipboard

---------------
-- functions --
---------------

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    -- group = augroup("highlight_yank"),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Run gofmt + goimports on save

local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require("go.format").goimports()
  end,
  group = format_sync_grp,
})

-- Remove lualine with Goyo

local goyo_group = vim.api.nvim_create_augroup('GoyoGroup', {clear = true})
vim.api.nvim_create_autocmd('User', {
    desc = 'Hide lualine on GoYo enter',
    group = goyo_group,
    pattern = 'GoyoEnter',
    callback = function()
       require("lualine").hide()
    end,
})
