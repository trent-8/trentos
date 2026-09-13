dofile(vim.g.base46_cache .. "cmp")

local cmp = require "cmp"

-- Consume Alt chords when the menu is closed; do not fall back to Escape+key.
local function menuAction(action)
  return cmp.mapping(function()
    if cmp.visible() then
      action()
    end
  end, { "i" })
end

local options = {
  completion = { completeopt = "menu,menuone,noinsert" },
  -- Select the first displayed entry, not an LSP-designated preselection.
  preselect = cmp.PreselectMode.None,

  -- Typing punctuation must not confirm an LSP completion implicitly.
  confirmation = {
    get_commit_characters = function()
      return {}
    end,
  },

  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },

  mapping = {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),

    ["<A-j>"] = menuAction(function()
      cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
    end),
    ["<A-Down>"] = menuAction(function()
      cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
    end),
    ["<A-k>"] = menuAction(function()
      cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
    end),
    ["<A-Up>"] = menuAction(function()
      cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
    end),
    ["<A-l>"] = menuAction(function()
      cmp.confirm { behavior = cmp.ConfirmBehavior.Insert, select = false }
    end),
    ["<A-Right>"] = menuAction(function()
      cmp.confirm { behavior = cmp.ConfirmBehavior.Insert, select = false }
    end),
    ["<A-h>"] = menuAction(function()
      cmp.abort()
    end),
    ["<A-Left>"] = menuAction(function()
      cmp.abort()
    end),
  },

  sources = {
    { name = "nvim_lsp" },
    { name = "vimtex" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "nvim_lua" },
    { name = "async_path" },
  },
}

return vim.tbl_deep_extend("force", options, require "nvchad.cmp")
