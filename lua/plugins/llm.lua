return {}
-- return {
--   {
--     "huggingface/llm.nvim",
--     opts = {
--       backend = "ollama",
--       model = "codellama:7b",
--       url = "http://localhost:11434", -- llm-ls uses "/api/generate"
--       -- fim = {
--       --   enabled = true,
--       --   prefix = "<|fim_prefix|>",
--       --   middle = "<|fim_middle|>",
--       --   suffix = "<|fim_suffix|>",
--       -- },
--       tokens_to_clear = { "<EOT>" },
--       fim = {
--         enabled = true,
--         prefix = "<PRE> ",
--         middle = " <MID>",
--         suffix = " <SUF>",
--       },
--       request_body = {
--         options = {
--           temperature = 0.2,
--           top_p = 0.9,
--         },
--       },
--       -- context_window = 4096, -- max number of tokens for the context window
--     },
--   },
-- }
