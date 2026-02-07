options = require("nvchad.configs.mason")

options.ensure_installed = {
  "black",
  "clangd",
  "rust-analyzer",
  "python-lsp-server",
  "mypy",
  "isort"
}

return options
