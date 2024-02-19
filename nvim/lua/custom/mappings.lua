local M = {}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line",
    },
    ["<leader>dr"] = {
      "<cmd> DapContinue <CR>",
      "Start or continue the debugger",
    },
    ["<F8>"] = {
      "<cmd> DapStepOver <CR>",
      "Step Over",
    },
    ["<F7>"] = {
      "<cmd> DapStepInto <CR>",
      "Step Into",
    }

  }
}

return M
