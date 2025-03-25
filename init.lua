-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.cmd([[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none

  tnoremap <Esc> <C-\><C-n>
]])

vim.api.nvim_create_user_command("CopyPath", function(context)
  local full_path = vim.fn.expand("%:p") -- Ensure to use absolute path here
  local file_path = nil

  if not context["args"] then
    local relative_path = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")
    file_path = relative_path
  else
    if context["args"] == "nameonly" then
      file_path = vim.fn.fnamemodify(full_path, ":t")
    elseif context["args"] == "absolute" then
      file_path = full_path
    else
      local relative_path = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")
      file_path = relative_path
    end
  end

  if type(file_path) ~= "string" then
    -- print an error
    vim.print("Failed to get file path")
    return
  end

  vim.fn.setreg("+", file_path)
  vim.print("Filepath copied to clipboard!")
end, {
  bang = false,
  nargs = "*", -- Allow zero or more arguments
  force = true,
  desc = "Copy current file path to clipboard",
  complete = function()
    return { "nameonly", "relative", "absolute" }
  end,
})
