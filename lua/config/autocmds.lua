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
      require("FTerm").run({ "clang++", "--std=c++20", path, "-o", "a.out", "&&", "./a.out" })
    end, { desc = "[r]un current cpp file" })
    vim.keymap.set("n", "<Leader>dd", function()
      local path = vim.fn.expand("%:p")
      require("FTerm").run({ "clang++", "--std=c++20", "--debug", path, "-o", "a.out" })
    end, { desc = "Build current file for debugging" })
  end,
  pattern = {
    "cpp",
  },
})
