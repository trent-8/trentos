dofile(vim.g.base46_cache .. "mason")

return {
  PATH = "skip",

  ui = {
    icons = {
      package_pending = " ",
      package_installed = " ",
      package_uninstalled = " ",
    },
  },

  ensure_installed = {
    "black",
    "clangd",
    "rust-analyzer",
    "python-lsp-server",
    "mypy",
    "isort"
  },

  max_concurrent_installers = 10,
}
