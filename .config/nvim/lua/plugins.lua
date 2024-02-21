local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use {
    -- Packer nvim packet manager
    'wbthomason/packer.nvim'
  }
  -- My plugins here
  use { -- theme
    -- 'navarasu/onedark.nvim'
    "ellisonleao/gruvbox.nvim"
  }
  use { -- file explorer
    'nvim-tree/nvim-tree.lua'
  }
  use { -- icons for the names
    'nvim-tree/nvim-web-devicons'
  }
  use { -- bar at the bottom of thr screen
    'nvim-lualine/lualine.nvim'
  }
  use { -- syntax higlightinh
    'nvim-treesitter/nvim-treesitter'
  }
  use { -- fzf search 
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use { -- LSP configuration
    'neovim/nvim-lspconfig',
    -- tool to install LSP 
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    -- LSP tool
    'j-hui/fidget.nvim',
    -- Additional lua configuration
    'folke/neodev.nvim',
  }
  use { -- Autocompletion
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
  }
  use { -- snippets to save time while coding
   'rafamadriz/friendly-snippets'
  }
  use { -- automatic close parenthesis
	  'windwp/nvim-autopairs',
    config = function() require('nvim-autopairs').setup {} end
  }
  use {
    'norcalli/nvim-colorizer.lua'
  }
  use { -- markdown previewer in browser
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
  }
  use { -- fancy tabs on the top
    'akinsho/bufferline.nvim',
    tag = "v3.*",
    requires = 'nvim-tree/nvim-web-devicons'
  }
  use { -- toggle a customizable Terminal 
    "akinsho/toggleterm.nvim", tag = '*'
  }
  use { -- add indent blankline
    'lukas-reineke/indent-blankline.nvim'
  }
  use { -- simple greeter as startup
    'goolord/alpha-nvim',
    config = function ()
      require'alpha'.setup(require'alpha.themes.dashboard'.config)
    end
  }
  -- Packer
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
