local M = {}

M.RunTestForCurrentFile = function(singleFunction)
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

  local get_current_function_name = function()
    local ts_utils = require("nvim-treesitter.ts_utils")
    local node = ts_utils.get_node_at_cursor(0, true)
    while node and node:type() ~= "method_declaration" do
      node = node:parent()
    end
    if not node then
      return ""
    end
    for i = 0, node:named_child_count() - 1, 1 do
      local child = node:named_child(i)
      if child:type() == "name" then
        return vim.treesitter.get_node_text(child, 0)
      end
    end
    return ""
  end

  local current_file_path = get_pwd_relative_file_path()
  local pod_name = get_pod_name()
  local function_name = get_current_function_name()
  local cmd = pod_name .. " -- vendor/phpunit/phpunit/phpunit " .. current_file_path
  if singleFunction and function_name ~= "" then
    cmd = cmd .. " --filter " .. function_name
  end

  require("FTerm").run({ "/usr/local/bin/kubectl", "exec", "-it", cmd })
end

return M
