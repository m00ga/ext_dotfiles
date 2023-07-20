local dap = require("dap")
local dapui = require("dapui")

dap.adapters.lldb = {
	type = 'executable',
	command = '/opt/homebrew/Cellar/llvm/15.0.5/bin/lldb-vscode',
	name = 'lldb'
}

dap.configurations.cpp = {
	{
		name = 'Launch',
    	type = 'lldb',
    	request = 'launch',
		program = function()
    	  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    	end,
    	cwd = '${workspaceFolder}',
    	stopOnEntry = false,
    	args = {},
	},
}

dap.configurations.c = dap.configurations.cpp


vim.keymap.set('n', '<leader>b', "<Cmd>lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set('n', '<leader>c', "<Cmd>lua require'dap'.continue()<CR>")
vim.keymap.set("n", "<Leader>dsv", ":lua require('dap').step_over()<CR>")
vim.keymap.set("n", "<Leader>dsi", ":lua require('dap').step_into()<CR>")
vim.keymap.set("n", "<Leader>dso", ":lua require('dap').step_out()<CR>")

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
