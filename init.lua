-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.cmd([[
  " highlight Normal guibg=none
  " highlight NonText guibg=none
  " highlight Normal ctermbg=none
  " highlight NonText ctermbg=none

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

vim.api.nvim_create_user_command("CopyFunction", function()
  local ts_utils = require("nvim-treesitter.ts_utils")
  local parsers = require("nvim-treesitter.parsers")

  if not parsers.has_parser() then
    vim.print("No TreeSitter parser available for this filetype")
    return
  end

  local node = ts_utils.get_node_at_cursor()
  if not node then
    vim.print("No node found at cursor")
    return
  end

  -- Walk up the tree to find a function definition
  local function_node = node
  while function_node do
    local node_type = function_node:type()
    -- Debug: print the current node type
    -- vim.print("Checking node type: " .. node_type)

    if node_type == "function_definition" or node_type == "async_function_definition" then
      break
    end
    function_node = function_node:parent()
  end

  if not function_node then
    vim.print("Not inside a function")
    return
  end

  -- Get the function name - try multiple approaches
  local function_name = nil

  -- Method 1: Try to get name field
  for child in function_node:iter_children() do
    if child:type() == "identifier" then
      function_name = vim.treesitter.get_node_text(child, 0)
      break
    end
  end

  -- Method 2: If that didn't work, try getting the second child (common pattern)
  if not function_name then
    local children = {}
    for child in function_node:iter_children() do
      table.insert(children, child)
    end
    if #children >= 2 and children[2]:type() == "identifier" then
      function_name = vim.treesitter.get_node_text(children[2], 0)
    end
  end

  if not function_name then
    vim.print("Could not find function name")
    return
  end

  vim.fn.setreg("+", function_name)
  vim.print("Function name copied to clipboard: " .. function_name)
end, {
  bang = false,
  nargs = 0,
  force = true,
  desc = "Copy current function name to clipboard",
})

vim.api.nvim_create_user_command("FormatJSON", function()
  vim.cmd([[:%!jq .]])
end, {})

vim.api.nvim_create_user_command("Voice", function(opts)
  local duration = opts.args and tonumber(opts.args) or 15
  local temp_wav = "/tmp/temp_whisper.wav"
  local temp_txt = "/tmp/temp_whisper.txt"

  local record_cmd = string.format("sox -d %s trim 0 %d", temp_wav, duration)
  local whisper_cmd =
    string.format("whisper %s --model small --language en --fp16 False --output_format txt --output_dir /tmp", temp_wav)
  local cleanup_cmd = string.format("rm -f %s %s", temp_wav, temp_txt)

  -- Set global variable for lualine to display
  local remaining = duration
  _G.whisper_status = "🎤 Recording... " .. remaining .. " seconds remaining"

  -- 3 second delay before recording
  vim.fn.system("sleep 3")

  -- Start countdown timer and recording asynchronously
  local timer = vim.fn.timer_start(1000, function()
    remaining = remaining - 1
    if remaining > 0 then
      _G.whisper_status = "🎤 Recording... " .. remaining .. " seconds remaining"
    else
      _G.whisper_status = "🔄 Transcribing audio..."
    end
  end, { ["repeat"] = duration })

  vim.fn.jobstart(record_cmd, {
    on_exit = function(_, exit_code)
      vim.fn.timer_stop(timer)
      if exit_code ~= 0 then
        vim.fn.system(cleanup_cmd)
        _G.whisper_status = "❌ Recording failed"
        vim.defer_fn(function()
          _G.whisper_status = nil
        end, 3000)
        return
      end

      -- Continue with transcription
      vim.schedule(function()
        _G.whisper_status = "🔄 Transcribing audio..."

        vim.fn.jobstart(whisper_cmd, {
          on_exit = function(_, whisper_exit_code)
            if whisper_exit_code ~= 0 then
              vim.fn.system(cleanup_cmd)
              _G.whisper_status = "❌ Transcription failed"
              vim.defer_fn(function()
                _G.whisper_status = nil
              end, 3000)
              return
            end

            local transcription = vim.fn.system("cat " .. temp_txt)
            if vim.v.shell_error ~= 0 then
              vim.fn.system(cleanup_cmd)
              _G.whisper_status = "❌ Transcription failed"
              vim.defer_fn(function()
                _G.whisper_status = nil
              end, 3000)
              return
            end

            transcription = transcription:gsub("^%s*(.-)%s*$", "%1")
            vim.fn.setreg("+", transcription)
            vim.fn.system(cleanup_cmd)

            _G.whisper_status = nil
            vim.print("Transcription copied to clipboard!")
          end,
        })
      end)
    end,
  })
end, {
  bang = false,
  nargs = "?",
  force = true,
  desc = "Record audio and transcribe to clipboard (default 15s, specify duration as argument)",
})

require("conform").setup({
  formatters_by_ft = {
    html = { "prettierd", "prettier", stop_after_first = true },
    htmldjango = { "prettierd", "prettier", stop_after_first = true },
    markdown = { "prettierd", "prettier", stop_after_first = true },
    -- python = { "black" },
    json = { "jq" },
  },
})

require("lspconfig").ruff.setup({
  init_options = {
    settings = {
      -- Ruff language server settings go here
    },
  },
})

require("lspconfig").pyright.setup({
  settings = {
    pyright = {
      -- Using Ruff's import organizer
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        -- Ignore all files for analysis to exclusively use Ruff for linting
        ignore = { "*" },
      },
    },
  },
})
