return {
    {
        'mfussenegger/nvim-dap',

        dependencies = {

            -- fancy UI for the debugger
            {
                'rcarriga/nvim-dap-ui',
        -- stylua: ignore
        keys = {
          { "<C-d>u", function() require("dapui").toggle({}) end, desc = "Dap UI" },
          { "<C-d>e", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
        },
                opts = {},
                config = function(_, opts)
                    -- setup dap config by VsCode launch.json file
                    -- require("dap.ext.vscode").load_launchjs()
                    local dap = require 'dap'
                    dap.adapters.gdb = {
                        type = 'executable',
                        command = 'gdb',
                        args = { '-i', 'dap' },
                    }
                    dap.adapters.codelldb = {
                        type = 'server',
                        host = '127.0.0.1',
                        port = 13000,
                        executable = {
                            command = 'codelldb',
                            args = { '--port', '{$port}' },
                            detached = false,
                        },
                        name = 'codelldb',
                    }
                    dap.adapters.lldb = {
                        type = 'executable',
                        command = 'lldb-vscode',
                        name = 'lldb',
                    }
                    dap.configurations.cpp = {
                        {
                            type = 'codelldb',
                            request = 'launch',
                            program = function()
                                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                            end,
                            --program = '${fileDirname}/${fileBasenameNoExtension}',
                            -- cwd = '${workspaceFolder}',
                            cwd = vim.fn.getcwd(),
                            terminal = 'integrated',
                        },
                    }
                    local dapui = require 'dapui'
                    dapui.setup(opts)
                    dap.listeners.after.event_initialized['dapui_config'] = function()
                        dapui.open {}
                    end
                    dap.listeners.before.event_terminated['dapui_config'] = function()
                        dapui.close {}
                    end
                    dap.listeners.before.event_exited['dapui_config'] = function()
                        dapui.close {}
                    end
                end,
            },

            -- virtual text for the debugger
            {
                'theHamsta/nvim-dap-virtual-text',
                opts = {},
            },

            -- mason.nvim integration
            {
                'jay-babu/mason-nvim-dap.nvim',
                dependencies = 'mason.nvim',
                cmd = { 'DapInstall', 'DapUninstall' },
                opts = {
                    -- Makes a best effort to setup the various debuggers with
                    -- reasonable debug configurations
                    automatic_installation = true,

                    -- You can provide additional configuration to the handlers,
                    -- see mason-nvim-dap README for more information
                    handlers = {},

                    -- You'll need to check that you have the required things installed
                    -- online, please don't ask me how to install them :)
                    ensure_installed = {
                        -- Update this to ensure that you have the debuggers for the langs you want
                    },
                },
            },
        },

    -- stylua: ignore
    keys = {
      { "<C-F9>", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
      { "<F9>",   function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
      { "<C-d>c", function() require("dap").continue() end,                                             desc = "Continue" },
      { "<C-d>a", function() require("dap").continue({ before = get_args }) end,                        desc = "Run with Args" },
      { "<C-d>C", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
      { "<C-d>g", function() require("dap").goto_() end,                                                desc = "Go to line (no execute)" },
      { "<F7>",   function() require("dap").step_into() end,                                            desc = "Step Into" },
      { "<C-d>j", function() require("dap").down() end,                                                 desc = "Down" },
      { "<C-d>k", function() require("dap").up() end,                                                   desc = "Up" },
      { "<C-d>l", function() require("dap").run_last() end,                                             desc = "Run Last" },
      { "<C-F8>", function() require("dap").step_out() end,                                             desc = "Step Out" },
      { "<F8>",   function() require("dap").step_over() end,                                            desc = "Step Over" },
      { "<C-d>p", function() require("dap").pause() end,                                                desc = "Pause" },
      { "<C-d>r", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
      { "<C-d>s", function() require("dap").session() end,                                              desc = "Session" },
      { "<C-d>t", function() require("dap").terminate() end,                                            desc = "Terminate" },
      { "<C-d>w", function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },
    },

        -- config = function()
        --   local Config = require 'lazyvim.config'
        --   vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })

        --   for name, sign in pairs(Config.icons.dap) do
        --     sign = type(sign) == 'table' and sign or { sign }
        --     vim.fn.sign_define('Dap' .. name, { text = sign[1], texthl = sign[2] or 'DiagnosticInfo', linehl = sign[3], numhl = sign[3] })
        --   end
        -- end,
    },
    {
        'jay-babu/mason-nvim-dap.nvim',
        dependencies = 'mason.nvim',
        cmd = { 'DapInstall', 'DapUninstall' },
        opts = {
            -- Makes a best effort to setup the various debuggers with
            -- reasonable debug configurations
            automatic_installation = true,

            -- You can provide additional configuration to the handlers,
            -- see mason-nvim-dap README for more information
            handlers = {},

            -- You'll need to check that you have the required things installed
            -- online, please don't ask me how to install them :)
            ensure_installed = {
                -- Update this to ensure that you have the debuggers for the langs you want
            },
        },
    },
}
