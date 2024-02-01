return {
  "L3MON4D3/LuaSnip",
  tag = "v2.2.0",
  dependencies = {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/my_snippets/" } })
    end,
  },
}
