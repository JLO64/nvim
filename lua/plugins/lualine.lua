return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    -- Add whisper status to lualine
    table.insert(opts.sections.lualine_x, 1, {
      function()
        return _G.whisper_status or ""
      end,
      cond = function()
        return _G.whisper_status ~= nil
      end,
    })
  end,
}