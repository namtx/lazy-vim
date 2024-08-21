-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- mapping for toggleterm
vim.api.nvim_set_keymap(
  "n",
  "<C-\\>",
  ":ToggleTerm<CR>",
  { noremap = true, silent = true, desc = "ToggleTerm vertical split" }
)
vim.api.nvim_set_keymap("t", "<C-\\>", "<C-\\><C-\\>", { noremap = true, silent = true, desc = "ToggleTerm exit" })
-- mapping jk to escape
vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true, silent = true, desc = "jk to ESC" })
--
