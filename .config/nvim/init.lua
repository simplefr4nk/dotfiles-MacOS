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
          { "<C-g>", "<cmd>Goyo<cr>", desc = "Toggle Goyo" },
        }
    },
    {  -- dimm not selected rows
        "junegunn/limelight.vim",
        keys = {
          { "<C-l>", "<cmd>Limelight!!<cr>", desc = "Toggle Limelight" },
        }
    },
    { -- markdown previewer
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
        keys = {
            { "<C-p>", "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle Markdown Preview"  }
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
          { "<C-n>", "<cmd>NvimTreeFindFileToggle<cr>", desc = "Toggle Nvim-Tree" },
        }
    },
    { -- Line above with name of buffers
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        keys = {
          { "<C-S-Left>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
          { "<C-S-Right>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
          { "<C-w>", "<cmd>bd<cr>", desc = "Close buffer" },
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
            "regex",
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
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },
    { -- Mason lsp downloader and installer
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    { -- Mason bridge to lspconfig
        "williamboman/mason-lspconfig.nvim",
        dependencies = {'williamboman/mason.nvim'},
        config = function()
            require("mason-lspconfig").setup {
                ensure_installed = {
                    "lua_ls", -- lua 
                    "bashls", -- bash
                    "yamlls", -- yaml
                    "marksman", -- markdown
                    "gopls", -- go
                },
            }
        end
    },
    { -- lsp
        "neovim/nvim-lspconfig",
        dependencies = {'williamboman/mason-lspconfig.nvim', 'williamboman/mason.nvim'},
        config = function()
            require'lspconfig'.lua_ls.setup({
                settings = { -- remove vim variable warning on lua file
                    Lua = {
                        runtime = {
                          -- Tell the language server which version of Lua you're using
                          -- (most likely LuaJIT in the case of Neovim)
                          version = 'LuaJIT',
                        },
                        diagnostics = {
                          -- Get the language server to recognize the `vim` global
                          globals = {
                            'vim',
                            'require'
                          },
                        },
                        workspace = {
                          -- Make the server aware of Neovim runtime files
                          library = vim.api.nvim_get_runtime_file("", true),
                        },
                        -- Do not send telemetry data containing a randomized but unique identifier
                        telemetry = {
                          enable = false,
                        },
                    },
                },
            })
            require'lspconfig'.bashls.setup({})
            require'lspconfig'.yamlls.setup({})
            require'lspconfig'.marksman.setup({})
            require'lspconfig'.gopls.setup({})
        end,

        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {}),
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, {}),
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})
    },
    { -- GO 
        "ray-x/go.nvim",
        dependencies = { -- optional packages
          "ray-x/guihua.lua",
          "neovim/nvim-lspconfig",
          "nvim-treesitter/nvim-treesitter",
        },
        config = function()
          require("go").setup()
        end,
        event = { "CmdlineEnter" },
        ft = { "go", "gomod" },
        build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    },
    { -- multiple cursor
        "brenton-leighton/multiple-cursors.nvim",
        version = "*",  -- Use the latest tagged version
        opts = {},  -- This causes the plugin setup function to be called
        keys = {
          {"<C-Down>", "<Cmd>MultipleCursorsAddDown<CR>", mode = {"n", "i"}},
          {"<C-j>", "<Cmd>MultipleCursorsAddDown<CR>"},
          {"<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>", mode = {"n", "i"}},
          {"<C-k>", "<Cmd>MultipleCursorsAddUp<CR>"},
          {"<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", mode = {"n", "i"}},
          {"<Leader>a", "<Cmd>MultipleCursorsAddMatches<CR>", mode = {"n", "x"}},
          {"<Leader>A", "<Cmd>MultipleCursorsAddMatchesV<CR>", mode = {"n", "x"}},
          {"<Leader>d", "<Cmd>MultipleCursorsAddJumpNextMatch<CR>", mode = {"n", "x"}},
          {"<Leader>D", "<Cmd>MultipleCursorsJumpNextMatch<CR>"},
        },
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
vim.opt.clipboard = unnamedplus -- copy to clipboard

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  -- group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})
