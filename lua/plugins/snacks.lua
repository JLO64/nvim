return {
  {
    "snacks.nvim",
    opts = {
      picker = {
        hidden = true,
        ignored = true,
        sources = {
          files = {
            hidden = true,
            ignored = true,
            include = {
              "*.json",
            },
          },
        },
      },
      dashboard = {
        preset = {
          pick = function(cmd, opts)
            return LazyVim.pick(cmd, opts)()
          end,
          header = header_4,
        -- stylua: ignore
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          --{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          -- { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        },
        sections = {
          {
            -- { section = "header", height = 10 },
            {
              section = "terminal",
              cmd = "viu ~/.config/nvim/neovim-mark-flat.png -t -h 13",
              height = 15,
              indent = 20,
              padding = 1,
              -- ttl = 10,
            },
            { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1, gap = 1 },
            { section = "startup" },
          },
          {
            pane = 2,
            padding = 1,
            { icon = " ", title = "Git Repositories", section = "projects", indent = 2, padding = 8, gap = 1 },
            { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, gap = 1, padding = 1 },
            {
              section = "terminal",
              cmd = "~/.config/nvim/dashboard_status.sh",
              height = 1,
              indent = 9,
              padding = 1,
              ttl = 10,
            },
            {
              section = "terminal",
              cmd = "~/.config/nvim/ccusage_status.sh",
              height = 1,
              indent = 9,
              ttl = 10,
            },
          },
        },
      },
    },
  },
}
