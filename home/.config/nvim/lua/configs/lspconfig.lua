require("nvchad.configs.lspconfig").defaults()

vim.lsp.config("basedpyright", {
  settings = {
    basedpyright = {
      analysis = {
        diagnosticMode = "openFilesOnly",
        typeCheckingMode = "standard",
      },
    },
  },
})

vim.lsp.config("ruff", {
  on_attach = function(client)
    -- BasedPyright provides more useful Python hover information.
    client.server_capabilities.hoverProvider = false
  end,
})

vim.lsp.config("texlab", {
  cmd = { vim.fn.stdpath("data") .. "/mason/bin/texlab" },
  settings = {
    texlab = {
      build = {
        executable = "latexmk",
        args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
        -- VimTeX owns the continuous latexmk process and PDF preview.
        onSave = false,
        forwardSearchAfter = false,
      },
      chktex = {
        onOpenAndSave = true,
        onEdit = true,
      },
      diagnosticsDelay = 300,
    },
  },
})

local servers = {
  "basedpyright",
  "ruff",
  "superhtml",
  "emmet_language_server",
  "clangd",
  "cssls",
  "rust_analyzer",
  "texlab",
}
vim.lsp.enable(servers)

vim.diagnostic.config {
  underline = true,
  update_in_insert = true,
  severity_sort = true,
}
