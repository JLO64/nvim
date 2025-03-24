return {
  {
    "olimorris/codecompanion.nvim",
    config = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      str = {
        chat = {
          -- adapter = "deepseek_coder",
          adapter = "ollama",
        },
        inline = {
          adapter = "ollama",
        },
      },
      -- adapters = {
      --   deepseek_coder = function()
      --     return require("codecompanion.adapters").extend("ollama", {
      --       name = "DeepSeek Coder", -- Give this adapter a different name to differentiate it from the default ollama adapter
      --       schema = {
      --         model = {
      --           default = "deepseek-coder-v2:latest",
      --         },
      --         num_ctx = {
      --           default = 16384,
      --         },
      --         num_predict = {
      --           default = -1,
      --         },
      --       },
      --     })
      --   end,
      --   qwq = function()
      --     return require("codecompanion.adapters").extend("ollama", {
      --       name = "QwQ",
      --       schema = {
      --         model = {
      --           default = "qwq:latest",
      --         },
      --         -- num_ctx = {
      --         --   default = 16384,
      --         -- },
      --         -- num_predict = {
      --         --   default = -1,
      --         -- },
      --       },
      --     })
      --   end,
      -- },
    },
  },
}
