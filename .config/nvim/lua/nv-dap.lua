local dap = require 'dap'
local dapui = require 'dapui'
dapui.setup {
  layouts = {
    {
      elements = {
        -- Elements can be strings or table with id and size keys.
        'scopes',
        -- "breakpoints",
        'stacks',
        -- "watches",
      },
      size = 50, -- 40 columns
      position = 'left',
    },
    {
      elements = {
        'console',
      },
      size = 0.25, -- 25% of total lines
      position = 'bottom',
    },
  },
  controls = {
    enabled = false,
  },
}
require('nvim-dap-virtual-text').setup()

local map = function(mode, keymap, command)
  vim.keymap.set(mode, keymap, command, { noremap = true, silent = true })
end

dap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
  dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
  dapui.close()
end

dap.configurations.cpp = {
  {
    name = 'Launch file',
    type = 'codelldb',
    request = 'launch',
    program = function()
      return _G.dap_program
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}

dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch',
    name = 'Launch file',

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = '${file}', -- This configuration will launch the current file if used.
    pythonPath = function()
      -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
      -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
      -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
      elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
      else
        return '/usr/bin/python3'
      end
    end,
  },
}

local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

local dap_woinput = {
  "python"
}

local dap_start = function()
  local cwd = vim.fn.getcwd()
  vim.ui.input({
    prompt = 'Path to executable: ' .. cwd .. '/',
    completion = 'file',
  }, function(input)
    if input then
      print ''
      _G.dap_program = input
      dap.continue()
    end
  end)
end

local dap_continue = function()
  if dap.session() ~= nil or has_value(dap_woinput, vim.bo.filetype) then
    dap.continue()
  else
    dap_start()
  end
end

map('n', '<leader>dt', "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
map('n', '<leader>dc', dap_continue)
map('n', '<leader>dd', "<cmd>lua require'dap'.disconnect()<cr>")
map('n', '<leader>dx', "<cmd>lua require'dap'.terminate()<cr>")
map('n', '<leader>di', "<cmd>lua require'dap'.step_into()<cr>")
map('n', '<leader>do', "<cmd>lua require'dap'.step_over()<cr>")
map('n', '<leader>dU', "<cmd>lua require'dapui'.toggle()<cr>")
