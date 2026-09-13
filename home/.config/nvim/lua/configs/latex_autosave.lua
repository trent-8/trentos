local M = {}
local timers = {}
local warned = {}

local function is_tex(buf)
  if not vim.api.nvim_buf_is_valid(buf) or not vim.api.nvim_buf_is_loaded(buf) then
    return false
  end
  local ft = vim.bo[buf].filetype
  return ft == "tex" or ft == "plaintex"
end

function M.save(target)
  for _, buf in ipairs(target and { target } or vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) then
      local options = vim.bo[buf]
      local name = vim.api.nvim_buf_get_name(buf)
      if
        (options.filetype == "tex" or options.filetype == "plaintex")
        and options.buftype == ""
        and options.modified
        and options.modifiable
        and not options.readonly
        and name ~= ""
      then
        -- No bang: normal write checks and BufWrite hooks still apply.
        local ok, err = pcall(vim.api.nvim_buf_call, buf, function()
          vim.cmd("silent update")
        end)
        if ok then
          warned[buf] = nil
        elseif warned[buf] ~= tostring(err) then
          warned[buf] = tostring(err)
          vim.notify("LaTeX autosave failed: " .. tostring(err), vim.log.levels.WARN)
        end
      end
    end
  end
end

local function cancel(buf)
  local timer = timers[buf]
  if timer then
    timers[buf] = nil
    timer:stop()
    timer:close()
  end
end

function M.stop()
  for buf in pairs(timers) do
    cancel(buf)
  end
end

function M.setup()
  M.stop()
  local group = vim.api.nvim_create_augroup("latex_autosave", { clear = true })
  local function schedule_save(args)
    local buf = args.buf
    cancel(buf)
    if not is_tex(buf) or not vim.bo[buf].modified then
      return
    end
    local timer = assert(vim.uv.new_timer())
    timers[buf] = timer
    -- One shot, restarted on each edit; no periodic polling.
    timer:start(
      2000,
      0,
      vim.schedule_wrap(function()
        if timers[buf] ~= timer then
          return
        end
        cancel(buf)
        -- Defer background TeX writes until that buffer is entered again.
        if
          is_tex(buf)
          and vim.api.nvim_get_current_buf() == buf
          and (not vim.v.exiting or vim.v.exiting == vim.NIL)
        then
          M.save(buf)
        end
      end)
    )
  end
  local function attach(args)
    local buf = args.buf
    cancel(buf)
    vim.api.nvim_clear_autocmds({ group = group, buffer = buf })
    if not is_tex(buf) then
      return
    end
    vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "TextChangedP", "BufEnter" }, {
      group = group,
      buffer = buf,
      callback = schedule_save,
    })
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufUnload", "BufWipeout", "BufLeave" }, {
      group = group,
      buffer = buf,
      callback = function(event)
        cancel(event.buf)
        warned[event.buf] = nil
      end,
    })
    if buf == vim.api.nvim_get_current_buf() then
      schedule_save(args)
    end
  end
  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    callback = attach,
  })
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) then
      attach({ buf = buf })
    end
  end
  vim.api.nvim_create_autocmd("VimLeavePre", {
    group = group,
    callback = M.stop,
  })
end

return M
