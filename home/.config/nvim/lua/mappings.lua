require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map({ "n", "i", "v" }, "<C-s>", "<cmd>write<CR>", { desc = "Save file" })

-- VS Code-style word boundaries: right to word ends, left to word starts.
-- Treat punctuation as a separate run and keep underscores inside words.
local wordSeparators = [=[`~!@#$%^&*()-=+[{]}\|;:'",.<>/?]=]
local function charClass(char)
  if char == "" or char:match("%s") then
    return "space"
  end
  return wordSeparators:find(char, 1, true) and "punctuation" or "word"
end

local function moveWord(direction)
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row, col = cursor[1], cursor[2]
  local line = vim.api.nvim_get_current_line()

  if direction > 0 then
    if col >= #line and row < vim.api.nvim_buf_line_count(0) then
      row, col = row + 1, 0
      line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]
    end
    while col < #line and charClass(line:sub(col + 1, col + 1)) == "space" do
      col = col + 1
    end
    local class = charClass(line:sub(col + 1, col + 1))
    while col < #line and charClass(line:sub(col + 1, col + 1)) == class do
      col = col + 1
    end
  else
    if col == 0 and row > 1 then
      row = row - 1
      line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]
      col = #line
    end
    while col > 0 and charClass(line:sub(col, col)) == "space" do
      col = col - 1
    end
    local class = charClass(line:sub(col, col))
    while col > 0 and charClass(line:sub(col, col)) == class do
      col = col - 1
    end
  end
  vim.api.nvim_win_set_cursor(0, { row, col })
end

-- Allow the insertion boundary after the last character in normal/visual mode.
vim.opt.virtualedit:append "onemore"
map({ "n", "i", "x" }, "<C-Right>", function()
  moveWord(1)
end, { desc = "Move to word end" })
map({ "n", "i", "x" }, "<C-Left>", function()
  moveWord(-1)
end, { desc = "Move to word start" })
