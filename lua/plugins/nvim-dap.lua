return {
  "mfussenegger/nvim-dap",
  specs = {
    {
      "mfussenegger/nvim-dap-python",
      dependencies = {
        "mfussenegger/nvim-dap",
        "rcarriga/nvim-dap-ui",
      },
      ft = "python", -- NOTE: ft: lazy-load on filetype
      config = function()
        -- local path = "~/dev/exercism/python/exercism-venv/bin/python"
        -- local path = "~/.pyenv/shims/python"
        local path = vim.fn.exepath "python"
        local debugpy = require("mason-registry").get_package "debugpy"
        if debugpy:is_installed() then
          path = vim.fn.expand "$MASON/packages/debugpy"
          if vim.fn.has "win32" == 1 then
            path = path .. "/venv/Scripts/python"
          else
            path = path .. "/venv/bin/python"
          end
        end
        require("dap-python").setup(path)
        require("dap-python").test_runner = "pytest"
        -- table.insert(require("dap").configurations.python, {
        --   type = "python",
        --   request = "launch",
        --   name = "My custom launch configuration",
        --   program = "${file}",
        --   args = { "-m", "-Xfrozen_modules=off", "debugpy.adapter" },
        --   pythonArgs = { "-Xfrozen_modules=off" },
        --   -- env = { "PYDEVD_DISABLE_FILE_VALIDATION" : "1" },
        -- })
      end,
    },
  },
  config = function()
    local dap = require "dap"
    --
    -- dap.adapters.python = {
    --   type = "executable",
    --   command = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python",
    --   args = { "-m", "-Xfrozen_modules=off", "debugpy.adapter" },
    --   options = {
    --     source_filetype = "python",
    --     timeout = 30000,
    --   },
    -- }
    dap.adapters.mix_task = {
      type = "executable",
      command = "/home/aakash/.local/share/nvim/mason/packages/elixir-ls/debug_adapter.sh",
      args = {},
    }

    -- dap.configurations.python = {
    --   {
    --     type = "python",
    --     request = "launch",
    --     name = "Launch file",
    --     program = "${file}",
    --     pythonPath = "python",
    --     -- pythonPath = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python",
    --   },
    -- }

    dap.configurations.elixir = {
      {
        type = "mix_task",
        name = "mix test",
        task = "test",
        taskArgs = { "--trace" },
        request = "launch",
        startApps = true, -- for Phoenix projects
        projectDir = "${workspaceFolder}",
        exitAfterTaskReturns = false,
        requireFiles = {
          "test/**/test_helper.exs",
          "test/**/*_test.exs",
        },
      },
    }
  end,
}
