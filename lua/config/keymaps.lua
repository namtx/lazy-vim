-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

vim.keymap.set(
  "n",
  "<Leader>ta",
  ":lua require('config.phptest').RunTestForCurrentFile() <CR>",
  { desc = "Run test for current file" }
)
vim.keymap.set(
  "n",
  "<Leader>tt",
  ":lua require('config.phptest').RunTestForCurrentFile(true) <CR>",
  { desc = "Run test for current function" }
)

vim.keymap.set("t", "<C-j><C-k>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', { desc = "Toggle FTerm" })
vim.keymap.set("n", "<C-j><C-k>", '<CMD>lua require("FTerm").toggle()<CR>', { desc = "Toggle FTerm" })

vim.keymap.set("n", "cp", function()
  local path = vim.fn.expand("%:p")
  local cwd = vim.fn.getcwd()
  local relative_file_path = path:gsub(cwd .. "/", "")
  vim.fn.setreg("+", relative_file_path)
  vim.notify('Copied "' .. relative_file_path .. '" to the clipboard!')
end, { desc = "Copy file path to cliboard" })

vim.keymap.set("n", "<Leader>gw", function()
  require("telescope.builtin").live_grep({ default_text = vim.fn.expand("<cword>") })
end, { desc = "[Telescope] live_grep <cword>" })

vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("n", "Y", "^yg_", { desc = "copy whole line without spaces" })

vim.opt.clipboard = "unnamed"
