local function bootstrap_pckr()
  local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

  if not (vim.uv or vim.loop).fs_stat(pckr_path) then
    vim.fn.system({
      'git',
      'clone',
      "--filter=blob:none",
      'https://github.com/lewis6991/pckr.nvim',
      pckr_path
    })
  end

  vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

require('pckr').add{
  -- My plugins here
  -- 'foo1/bar1.nvim';
  -- 'foo2/bar2.nvim';
  {'nvim-telescope/telescope.nvim', tag = '0.1.8', requires = { {'nvim-lua/plenary.nvim'} }};
  {
    'rose-pine/neovim',
    as = 'rose-pine',
    config = function()
        vim.cmd('colorscheme rose-pine')
    end
  };
  {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'};
  {'nvim-treesitter/playground'};
  {'mbbill/undotree'};
  {'tpope/vim-fugitive'};
  {'williamboman/mason.nvim'};
  {'williamboman/mason-lspconfig'};
  {'neovim/nvim-lspconfig'};
  {'hrsh7th/cmp-nvim-lsp'};
  {'hrsh7th/nvim-cmp'};
  {'hrsh7th/cmp-buffer'};
}

