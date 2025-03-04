-- this file isn't active - I've moved the logic to nvim-dap.lua, but leaving this just in case it's useful later

if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  "mfussenegger/nvim-dap-python",
  ft = "python",
  dependencies = {
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
  },
  config = function(_, opts)
    -- local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
    local path = "~/dev/exercism/python/exercism-venv/bin/python"
    require("dap-python").setup(path)
  end,
}
