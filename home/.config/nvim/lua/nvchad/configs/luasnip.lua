local luasnip = require "luasnip"

-- Retarget the bundled display-math snippet without editing plugin files.
local function retargetDisplayMath()
  for _, ft in ipairs { "tex", "plaintex" } do
    for _, snippet in ipairs(luasnip.get_snippets(ft) or {}) do
      if snippet.trigger == "$$" and snippet.name == "Display Math — \\[ … \\]" then
        snippet.trigger = "\\["
        snippet.wordTrig = false
      end
    end
  end
end

vim.api.nvim_create_autocmd("User", {
  pattern = "LuasnipSnippetsAdded",
  group = vim.api.nvim_create_augroup("latex_display_math_trigger", { clear = true }),
  callback = retargetDisplayMath,
})
retargetDisplayMath()

-- vscode format
require("luasnip.loaders.from_vscode").lazy_load { exclude = vim.g.vscode_snippets_exclude or {} }
require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.vscode_snippets_path or "" }

-- snipmate format
require("luasnip.loaders.from_snipmate").load()
require("luasnip.loaders.from_snipmate").lazy_load { paths = vim.g.snipmate_snippets_path or "" }

-- lua format
require("luasnip.loaders.from_lua").load()
require("luasnip.loaders.from_lua").lazy_load { paths = vim.g.lua_snippets_path or "" }
