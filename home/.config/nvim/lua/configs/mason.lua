options = require("nvchad.configs.mason")

-- Make Mason-managed executables available to LSP and formatter configs.
options.PATH = "prepend"

return options
