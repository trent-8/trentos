return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "mason-org/mason.nvim",
    opts = require "configs.mason",
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        "basedpyright",
        "ruff",
        "superhtml",
        "emmet-language-server",
        "css-lsp",
        "clangd",
        "clang-format",
        "rust-analyzer",
        "lua-language-server",
        "stylua",
        "prettierd",
        "texlab",
        "latexindent",
        "bibtex-tidy",
      },
      run_on_start = true,
      start_delay = 500,
      integrations = {
        ["mason-lspconfig"] = false,
        ["mason-null-ls"] = false,
        ["mason-nvim-dap"] = false,
      },
    },
  },

  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.vimtex_imaps_enabled = 0
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk = {
        callback = 1,
        continuous = 1,
        options = {
          "-verbose",
          "-file-line-error",
          "-synctex=1",
          "-interaction=nonstopmode",
        },
      }

      vim.g.vimtex_view_method = "general"
      vim.g.vimtex_view_general_viewer = "atril"
      vim.g.vimtex_view_general_options = "@pdf"
      vim.g.vimtex_view_automatic = 1

      vim.g.vimtex_quickfix_open_on_warning = 0
      vim.g.vimtex_quickfix_ignore_filters = {"Underfull", "Overfull", "LaTeX Warning: .\\+ float specifier changed to", "Package hyperref Warning: Token not allowed in a PDF string"}

      local group = vim.api.nvim_create_augroup("vimtex_auto_preview", { clear = true })
      vim.api.nvim_create_autocmd("User", {
        pattern = "VimtexEventInitPost",
        group = group,
        command = "VimtexCompile!",
        desc = "Automatically build and preview LaTeX projects",
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "tex", "plaintex" },
        group = group,
        callback = function(args)
          vim.keymap.set("n", "<leader>lv", "<cmd>VimtexView<cr>", {
            buffer = args.buf,
            desc = "LaTeX reopen preview",
          })
        end,
      })
    end,
  },

  {
    "micangl/cmp-vimtex",
    ft = { "tex", "plaintex", "bib" },
    dependencies = { "hrsh7th/nvim-cmp", "lervag/vimtex" },
    config = function()
      require("cmp_vimtex").setup {}
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = require "configs.treesitter",
  },
}
