require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "clangd", "cssls", "pylsp", "rust_analyzer", "vimtex" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
