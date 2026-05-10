return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    opts = "configs.lspconfig-opts",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = require "configs.mason"
  },

  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.vimtex_imaps_enabled = 0
      vim.g.vimtex_view_method = 'general'
      vim.g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
      vim.g.vimtex_quickfix_open_on_warning = 0
      vim.g.vimtex_quickfix_ignore_filters = {"Underfull", "Overfull", "LaTeX Warning: .\\+ float specifier changed to", "Package hyperref Warning: Token not allowed in a PDF string"}
    end,
  },

  {
    "micangl/cmp-vimtex",
    ft = "tex",
    config = function ()
      require('cmp_vimtex').setup({})
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = require "configs.treesitter"
  },
}
