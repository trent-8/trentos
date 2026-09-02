local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff_organize_imports", "ruff_format" },
    html = { "prettierd" },
    css = { "prettierd" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    rust = { "rustfmt" },
    tex = { "latexindent" },
    bib = { "bibtex-tidy" },
  },
}

return options
