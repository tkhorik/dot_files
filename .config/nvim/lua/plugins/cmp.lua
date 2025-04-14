-- return {
--   {
--     "hrsh7th/nvim-cmp",
--     event = "InsertEnter",
--     dependencies = {
--       "hrsh7th/cmp-nvim-lsp",
--       "hrsh7th/cmp-buffer",
--       "hrsh7th/cmp-path",
--       "saadparwaiz1/cmp_luasnip",
--       "L3MON4D3/LuaSnip",
--     },
--     enabled = true, -- Ensure this line is present or remove it entirely
--   },
-- }
return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter", -- Load on entering insert mode
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
      "hrsh7th/cmp-buffer", -- Buffer source
      "hrsh7th/cmp-path", -- Path source
      "hrsh7th/cmp-nvim-lua", -- Lua source for Neovim config
      "saadparwaiz1/cmp_luasnip", -- Snippet source
      "L3MON4D3/LuaSnip", -- Snippet engine
      "rafamadriz/friendly-snippets", -- Predefined snippets collection
      "onsails/lspkind.nvim", -- VSCode-like pictograms
    },
    enabled = true, -- Ensure this line is present or remove it entirely
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body) -- For LuaSnip users
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(), -- Navigate up
          ["<C-j>"] = cmp.mapping.select_next_item(), -- Navigate down
          ["<C-b>"] = cmp.mapping.scroll_docs(-4), -- Scroll docs up
          ["<C-f>"] = cmp.mapping.scroll_docs(4), -- Scroll docs down
          ["<C-Space>"] = cmp.mapping.complete(), -- Trigger completion menu
          ["<C-e>"] = cmp.mapping.abort(), -- Close completion menu
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection
        }),
        -- mapping = cmp.mapping.preset.insert({
        --   ["<C-k>"] = cmp.mapping.select_prev_item(), -- Navigate up
        --   ["<C-j>"] = cmp.mapping.select_next_item(), -- Navigate down
        --   ["<C-b>"] = cmp.mapping.scroll_docs(-4), -- Scroll docs up
        --   ["<C-f>"] = cmp.mapping.scroll_docs(4), -- Scroll docs down
        --   ["<C-Space>"] = cmp.mapping.complete(), -- Trigger completion menu
        --   ["<C-e>"] = cmp.mapping.abort(), -- Close completion menu
        --   ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection
        -- }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
          { name = "obsidian" }, -- Add this for Obsidian.nvim completions
        }),
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            menu = {
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              path = "[Path]",
            },
          }),
        },
      })
    end,
  },
}
