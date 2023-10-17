-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

function RunTestForCurrentFile()
  local get_pwd_relative_file_path = function()
    if not vim.api.nvim_buf_is_loaded(0) then
      return nil
    end

    local file_name = vim.fn.expand("%:p")

    if file_name == "" or file_name:sub(1, 1) == "." then
      return nil
    end

    local cwd = vim.fn.getcwd()

    local relative_file_path = file_name:gsub(cwd .. "/", "")

    return relative_file_path
  end

  local get_pod_name = function()
    local output =
      vim.fn.systemlist('kubectl get pods -l app.kubernetes.io/name=web -o jsonpath={".items[0].metadata.name"}')

    return output[1]
  end

  local current_file_path = get_pwd_relative_file_path()
  local pod_name = get_pod_name()
  vim.notify(pod_name)
  local cmd = pod_name .. " -- vendor/phpunit/phpunit/phpunit " .. current_file_path

  require("FTerm").run({ "/usr/local/bin/kubectl", "exec", "-it", cmd })
end

vim.keymap.set("n", "<Leader>tt", ":lua RunTestForCurrentFile() <CR>", { desc = "Run test for current file" })

vim.keymap.set("t", "<C-j><C-k>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', { desc = "Toggle FTerm" })
vim.keymap.set("n", "<C-j><C-k>", '<CMD>lua require("FTerm").toggle()<CR>', { desc = "Toggle FTerm" })

vim.keymap.set("n", "cp", function()
  local path = vim.fn.expand("%:p")
  local cwd = vim.fn.getcwd()
  local relative_file_path = path:gsub(cwd .. "/", "")
  vim.fn.setreg("+", relative_file_path)
  vim.notify('Copied "' .. relative_file_path .. '" to the clipboard!')
end, { desc = "Copy file path to cliboard" })

vim.keymap.set(
  "n",
  "<Leader>gw",
  "<CMD>Telescope live_grep default_text=" .. vim.fn.expand("<cword>") .. "<CR>",
  { desc = "Live grep word under the cursor" }
)

vim.keymap.set("i", "jk", "<Esc>")

vim.opt.clipboard = "unnamed"
