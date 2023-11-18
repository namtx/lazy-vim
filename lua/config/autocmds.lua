-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("cpp"),
  callback = function()
    vim.keymap.set("n", "<Leader>r", function()
      local path = vim.fn.expand("%:p")
      require("FTerm").run({ "g++", "--std=c++11", path, "-o", "a.out", "&&", "./a.out" })
    end, { desc = "[r]un current cpp file" })
  end,
  pattern = {
    "cpp",
  },
})
