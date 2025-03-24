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
  local full_path = vim.fn.glob("%:p")

  local file_path = nil
  if context["args"] == "nameonly" then
    file_path = vim.fn.fnamemodify(full_path, ":t")
  end

  -- get the file path relative to the project directory
  if context["args"] == "relative" then
    local relative_path = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")
    file_path = relative_path
  end

  if context["args"] == "absolute" then
    file_path = full_path
  end

  vim.fn.setreg("+", file_path)
  vim.print("Filepath copied to clipboard!")
end, {
  bang = false,
  nargs = 1,
  force = true,
  desc = "Copy current file path to clipboard",
  complete = function()
    return { "nameonly", "relative", "absolute" }
  end,
})
